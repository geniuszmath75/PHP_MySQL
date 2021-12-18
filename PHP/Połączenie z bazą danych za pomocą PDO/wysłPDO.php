<!DOCTYPE html>
<html>
     <head>

     	     <meta charset="utf-8">
     	     <style type="text/css">

                  td {
                        border: solid black 1px;
                        padding: 5px;
                  }
                  
            </style>

     </head>
     <body>

     	     <?php

     	     try
     	     {
     	            $conn = new PDO('mysql:host =localhost;dbname=ogloszenia', 'root', '');// połączenie z bazą danych

     	            $wynik = $conn->query("SELECT * FROM ogloszenie");

     	            echo "<table>";     	            
     	            if($wynik->rowCount() > 0) 
     	            {     	                  
                        echo "<tr>";
                        echo "<th>id</th>";
                        echo "<th>tytul</th>";
                        echo "<th>tresc</th>";
                        echo "</tr>";

     	                  while ($row = $wynik->fetch()) 
                        {
                              echo "<tr>";

                              echo "<td>" . $row["id"]    . "</td>";
                              echo "<td>" . $row["tytul"] . "</td>";
                              echo "<td>" . $row["tresc"] . "</td>";

                              echo "</tr>";
                        }
                  }else {
                  	echo "Nie ma nic w bazie danych.";
                  }
                  $wynik->closeCursor();
                  echo "</table>";

     	     }
     	     catch(PDOException $e)
     	     {
     	     	      echo "Błąd!" . $e->getMessage();
     	     }
            
            
            ?>

     </body>
</html>