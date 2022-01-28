from app.auth import gain_access, register
import os
import time

os.system('cls')
print("""
	------------------------------------------------------------
		Welcome, please select an option
	------------------------------------------------------------
""")
def home_inv(option=None):

	option = input("Connexion | Inscription | Quitter :\t")
	if option == "Connexion" :
		gain_access()
	elif option == "Inscription" :
		register()
	elif option == "Quitter" :
		os.system('cls')
		time.sleep(1); os._exit(0)
	else:
		print("Veuillez entrer un paramètre valide, il est sensible à la casse.")
		os.system('cls'); home_inv()

home_inv()
