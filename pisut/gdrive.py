from __future__ import print_function

import os.path
from collections import OrderedDict

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError


# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/drive.metadata.readonly']


def listDir(gFolder, q=None, pageSize=100, pageToken=None):
    """Shows basic usage of the Drive v3 API.
    Prints the names and ids of the first 10 files the user has access to.
    """
    if gFolder.startswith('http'):
        gFolder = os.path.split(gFolder)[1]

    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    gPath = "pisut"
    gToken = os.path.join(gPath,"client_toaken.json")
    gCredential = next(iter(filter(lambda f: f.startswith('client_secret') and f.endswith('.json'), os.listdir(gPath))),None)
    if not gCredential:
        print("Credential not found")
        return None
    
    if os.path.exists(gToken):
        creds = Credentials.from_authorized_user_file(gToken, SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(gCredential, SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(gToken, 'w') as token:
            token.write(creds.to_json())

    try:
        # https://developers.google.com/discovery/v1/building-a-client-library
        # https://developers.google.com/drive/api/reference/rest/v2/files/list
        # https://developers.google.com/drive/api/guides/search-files#python
        # https://developers.google.com/drive/api/reference/rest/v3/files#File
        # https://developers.google.com/drive/api/guides/mime-types
        service = build('drive', 'v3', credentials=creds)

        # Call the Drive v3 API
        params = {
            'orderBy': 'name',
            'pageSize': pageSize, 
            'pageToken': pageToken,
            'fields': "nextPageToken, files(id, name, size, modifiedTime)",
            'q': "'"+gFolder+"' in parents"+ (' and '+q if q else '') if q else ''
        }
        results = service.files().list(**params).execute()
        return results
    
    except HttpError as error:
        # TODO(developer) - Handle errors from drive API.
        print(f'An error occurred: {error}')
        return None


if __name__ == '__main__':
    import json
    import pickle
    import pandas as pd
    
    fieldSheet = "https://docs.google.com/spreadsheets/d/1vJByO72Y0EbVQRenX6SUUCK9JkBXcUvA/edit?pli=1#gid=41482437"
    dataPath = 'pisut'
    plotPickle = os.path.join(dataPath,"plotData.pickle")
    pictPickle = os.path.join(dataPath,"pictData.pickle")
    pictExcel = os.path.join(dataPath,"pictData.xlsx")

    if os.path.isfile(plotPickle):
        with open(plotPickle,'rb') as f:
            plotData = pickle.load(f)
    else:
        plotDrive = "https://drive.google.com/drive/folders/1qwpq-Zb6OJumqNJ_oDT_gYj9GbX_Hpmn"
        plotQuery = "mimeType = 'application/vnd.google-apps.folder'"
        plotRecords = listDir(plotDrive, plotQuery, 1000)

        print(plotRecords)
        plotData = pd.DataFrame.from_records(plotRecords['files'])
        plotData['plot'] = plotData['name'].apply(lambda x: x[:9])
        plotData['name'] = plotData['name'].apply(lambda x: x[10:].strip())

        with open(plotPickle,'wb') as f:
                pickle.dump(plotData,f)

    #plotData = plotData.loc[:,~plotData.columns.isin(['modifiedTime'])]
    #pictDrive = "https://drive.google.com/drive/folders/13i_lYn_PDOIvobBi9t1NVH_PFVVfICF8"
    print(plotData)

    if os.path.isfile(pictPickle):
        with open(pictPickle,'rb') as f:
            pictData = pickle.load(f)
    else:    
        pictQuery = "mimeType = 'image/jpeg'"
        pictData = None
        lastIndex = 0
        for index, row in plotData.iterrows():
            tempPickle = os.path.splitext(pictPickle)[0]+'_'+str(index+1)+'.pickle'
            if os.path.isfile(tempPickle):
                with open(tempPickle,'rb') as f:
                    pictData = pickle.load(f)
                    lastIndex = index + 1
                break
        print("last index of pickle", lastIndex)
        for index, row in plotData.iterrows():
            if index< lastIndex :
                continue
            print (index+1, row['plot'])
            #continue
            tempPickle = os.path.splitext(pictPickle)[0]+'_'+str(index+1)+'.pickle'
            lastPickle = os.path.splitext(pictPickle)[0]+'_'+str(index)+'.pickle'
            if os.path.isfile(tempPickle):
                os.remove(lastPickle)

            print('id:',row['id'], 'plot:', row['plot'], '(',index,'of', len(plotData),')')
            pictDrive = row['id']
            pictRecords = listDir(pictDrive, pictQuery, 1000)
            pictResults = pictRecords
            pictPageNo = 1
            #print(pictPageNo, pictResults['nextPageToken'])
            while 'nextPageToken' in pictResults:
                pictPageNo += 1
                pictResults = listDir(pictDrive, pictQuery, 1000, pictResults['nextPageToken'])
                pictRecords['files'] += pictResults['files']
                #print(pictPageNo, pictResults['nextPageToken'])
            #print(pictRecords)
            pictTemp = pd.DataFrame.from_records(pictRecords['files'])
            pictTemp['tag'] = pictTemp['name'].apply(lambda x: x[:7])
            pictTemp['type'] = pictTemp['name'].apply(lambda x: x[7:11])
            pictTemp.insert(0,'plot',row['plot'])
            print('add more', len(pictTemp), 'records')

            if pictData is None:
                pictData = pictTemp
            else:
                pictData = pd.concat([pictData, pictTemp])
            print(pictData)
            #if index == 3:
            #    break
            with open(tempPickle,'wb') as f:
                pickle.dump(pictData,f)
        if (not pictData is None):
            with open(pictPickle,'wb') as f:
                    pickle.dump(pictData,f)

    print(pictData)
    if (not pictData is None) and not os.path.isfile(pictExcel):
        pictData.to_excel(pictExcel)
    