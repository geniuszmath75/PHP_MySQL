<!DOCTYPE html>
<html>
     <head>

	     <meta charset="utf-8">

	     <style type="text/css">

	     	td, th {
	     		border: solid black 1px;
	     		padding: 5px;
	     	}
	     	
	     </style>

     </head>
     <body>

     	     <?php

           $conn = mysqli_connect("localhost", "root", "", "ogloszenia") or die("Błąd"); // połączenie z bazą danych

           $q = "SELECT id, tytul, tresc FROM ogloszenie"; //treść zapytania SQL
           $result = mysqli_query($conn, $q) or die("Problemy z odczytaniem danych!"); //wykonanie zapytania SQL
           //$ile = mysqli_num_rows($result); odczytanie liczby zwróconych rekordów

           if(mysqli_num_rows($result) > 0) {
                  
                  echo "<table>";
                  echo "<tr>";
                  echo "<th>id</th>";
                  echo "<th>tytul</th>";
                  echo "<th>tresc</th>";
                  echo "</tr>";

                  while($row = mysqli_fetch_assoc($result)){
                        //echo "<tr>";

                        echo "<td>" . $row["id"] . "</td>";
                        echo "<td>" . $row["tytul"] . "</td>";
                        echo "<td>" . $row["tresc"] . "</td>";

                       echo "</tr>";
                  }
                  echo "</table>";

            }else {
                  echo "Nie ma nic w bazie danych";
            }

           mysqli_close($conn); //zakończenie połączenia

     	     ?>

     </body>
</html>