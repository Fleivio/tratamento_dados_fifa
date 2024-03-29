import sqlite3
import pandas as pd


def gen_insert_query(df, values_format):
    result = ""
    for i in range(0, len(df)):
        line = df.values[i]
        result += values_format.format(*line)

    return result[:-1] + ";\n"


def gen_player_query(cnx):
    player_query = "SELECT player_api_id, player_name, birthday, height, weight FROM Player"

    df = pd.read_sql_query(player_query, cnx)

    sql_insert_player = "insert into Jogador (jogador_api_id, nome, data_nascimento, altura, peso) values "
    sql_player_values = "\n({},\"{}\",\"{}\", {}, {}),"

    sql_insert_player += gen_insert_query(df, sql_player_values)

    return sql_insert_player


def gen_team_query(cnx):
    team_query = "SELECT team_api_id, team_long_name, team_short_name FROM Team"

    df = pd.read_sql_query(team_query, cnx)

    sql_insert_team = "insert into Time (id_time, time_nome, time_sigla) values "
    sql_team_values = "\n({},\"{}\",\"{}\"),"

    sql_insert_team += gen_insert_query(df, sql_team_values)

    return sql_insert_team


if __name__ == "__main__":
    cnx = sqlite3.connect('./database.sqlite')
    with open("dmlTime.sql", "w") as team_insert:
        team_insert.write(gen_team_query(cnx))
    with open("dmlJogador.sql", "w") as player_insert:
        player_insert.write(gen_player_query(cnx))