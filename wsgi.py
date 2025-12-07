import importlib.util
import sys
import os

# Path to the original app file (renamed to underscored filename)
APP_PATH = os.path.join(os.path.dirname(__file__), "app_tf.py")

spec = importlib.util.spec_from_file_location("app_tf_module", APP_PATH)
app_tf = importlib.util.module_from_spec(spec)
spec.loader.exec_module(app_tf)

# Gunicorn will look for a WSGI callable named `application` in this module.
# The Flask app object in `app_tf.py` is named `app`, so expose it as `application`.
try:
    application = getattr(app_tf, "app")
except Exception:
    # Fallback: if `app` not found, raise an informative error
    raise RuntimeError("Could not find Flask `app` object in app_tf.py")
