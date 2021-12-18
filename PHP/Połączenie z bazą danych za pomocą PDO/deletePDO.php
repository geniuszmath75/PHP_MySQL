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

                       $wynik = $conn->query("DELETE FROM ogloszenie WHERE id = 6");

     	                 if($wynik !== false) {
                             echo 'Usunięto rekord o id = 6.';

                       }else {
                             echo 'Wystąpił błąd podczas usuwania rekordu.';
                       }	

                  }
     	           catch(PDOException $e)
                 {
                 	     echo 'Wystąpił błąd biblioteki PDO: ' . $e->getMessage();
                 }

     	     ?>

     </body>
</html>