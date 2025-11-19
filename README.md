uv add alembic asyncpg psycopg sqlalchemy
uv add fastapi pydantic pydantic-settings uvicorn

если хотим чтобы при выходе из with engine.begin() as conn:
делался COMMIT (неявно) -> begin()
если нужен ROLLBAC -> connect() и в конце явно conn.commit()
