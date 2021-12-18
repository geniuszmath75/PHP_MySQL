<!DOCTYPE html>
<html>
     <head>

	<meta charset="utf-8">
	
     </head>
     <body>

     	     <?php

     	           try
     	           {
     	                 if(isset($_POST["imie"]) ){
     	                       $imie = $_POST["imie"];
                             $nazwisko = $_POST["nazwisko"];
                             $telefon = $_POST["numer"];
                             $email = $_POST["email"];

                             if(empty($imie) || empty($nazwisko) || empty($telefon) || empty($email) ){
                                   echo "Wypełnij wszystkie pola!";
                             }else{

                             	     $conn = new PDO('mysql:host=localhost;dbname=ogloszenia', 'root', '');

                                   $wynik = "INSERT INTO uzytkownicy(imie, nazwisko, telefon, email) VALUES('$imie', '$nazwisko', '$telefon', '$email')";

                                   if($wynik) {
                                         echo 'Dodano użytkownika.';
                                   }else {
                                         echo 'Nie udało się dodać użytkownika.';
                                   }
                             }	
     	                 }	
                        
     	           }
     	           catch(PDOException $e)
     	           {
     	           	     echo 'Wystąpił błąd biblioteki PDO: '. $e->getMessage();
     	           }

     	     ?>

     	     <form method="POST" action="zap.php">

                  Imie: <input type="text" name="imie"> <br>      
                  Nazwisko: <input type="text" name="nazwisko"> <br>
                  Nr telefonu: <input type="number" name="numer"> <br>
                  Email: <input type="email" name="email"> <br>

                  <input type="submit" value="Zapisz">
           </form>

     </body>
</html>