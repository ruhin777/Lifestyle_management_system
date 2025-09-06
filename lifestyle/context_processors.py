from .models import User


def current_user(request):
    uid = request.session.get("user_id")
    user = None
    if uid:
        try:
            user = User.objects.get(pk=uid)
        except User.DoesNotExist:
            user = None
    return {"current_user": user}