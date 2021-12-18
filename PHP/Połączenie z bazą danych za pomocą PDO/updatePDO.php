<!DOCTYPE html>
<html>
     <head>

     	     <meta charset="utf-8">
	
     </head>
     <body>

     	     <?php

     	           try
     	           {

                       $conn = new PDO('mysql:host=localhost;dbname=ogloszenia', 'root', '');

                       $wynik = $conn->query("UPDATE zarzadcy SET
                       	        stanowisko = 'moderator',
     	                 	     	  nick = 'Dam4500'
     	                 	     	  WHERE id = 2");

     	                 if($wynik !== false) {
                             echo 'Zaktualizowano listę zarządców.';

                       }else {
                             echo 'Nie udało się zaktualizować listę zarządców.';
                       }	

                  }
     	           catch(PDOException $e)
                 {
                 	     echo 'Wystąpił błąd biblioteki PDO: ' . $e->getMessage();
                 }

     	     ?>

     </body>
</html>