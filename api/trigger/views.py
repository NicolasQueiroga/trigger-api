from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.response import Response
from django.core.mail import EmailMessage
from django.template.loader import get_template


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def receive_answer(request, *args, **kwargs):
    return Response(request.data, status=status.HTTP_200_OK)

def email_trigger():
    ctx = {} # {"project": project, "sectors": sectors_list, "scopes": scopes_list}
    message = get_template("emails/send_warning.html").render(
        context=ctx
    )
    mail = EmailMessage(
        subject="Status do projeto atualizado",
        body=message,
        from_email="",
        to="",
    )
    mail.content_subtype = "html"
    return mail.send()