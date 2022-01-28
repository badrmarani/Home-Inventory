import mysql.connector
import os
import time

from app.interface import home


connection = mysql.connector.connect(
    host = 'localhost',
    port = '3306',
    database = 'Home',
    user = 'root',
    password = 'toor'
)
cursor = connection.cursor()

def gain_access(Username=None, Password=None):

    Username = str(input("Entrez votre nom d'utilisateur :\t"))
    Password = str(input("Entrez votre mot de passe :\t"))

    if not len(Username or Password) < 1:
        if True:
            cursor.execute('SELECT user_name, user_password FROM User')
            data = cursor.fetchall()
            if (Username, Password) in data :
                print("Connexion réussie !")
                time.sleep(1)
                home(Username)
            else :
                print("Le mot de passe ou le nom d'utilisateur n'existe pas")
        else:
            print("Erreur de connexion au système")

    else:
        print("Veuillez essayer de vous connecter à nouveau.")
        os.system('cls'); gain_access()

def register(Username=None, Password1=None, Password2=None):
    Username = input("Entrez votre nom d'utilisateur :\t")
    Password1 = input("Entrez votre mot de passe :\t")
    Password2 = input("Confirmez votre mot de passe :\t")


    if not len(Password1) <= 6:
        if not Username == None:
            if len(Username) < 1:
                print("Veuillez fournir un nom d'utilisateur")
                time.sleep(1); os.system('cls');
                register()
            else:
                if Password1 == Password2:

                    cursor.execute("insert into user (user_name, user_password, stock_id) values (%s, %s, 2)", (Username, Password1))
                    connection.commit()

                    print("Utilisateur créé avec succès !")
                    print("Veuillez vous connecter pour continuer...")
                    time.sleep(1); os.system('cls');
                    gain_access()

                else:
                    print("Les mots de passe ne sont pas identiques")
                    time.sleep(1); os.system('cls');
                    register()
    else:
        print("Mot de passe trop court")
        time.sleep(1); os.system('cls');
        register()
