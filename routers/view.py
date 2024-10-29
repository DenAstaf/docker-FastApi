from fastapi import APIRouter


router = APIRouter(prefix='', tags=['Получение информации о ping'])


@router.get("/ping/", status_code=200)
def ping():
    return {"message": "pong"}
