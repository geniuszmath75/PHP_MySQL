<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>06.12</title>
    <style>
        .zadanie {
            width: 50%;
            height: auto;
            background-color: lightgreen;
        }

        .tytul {
            font-size: 20px;
            font-weight: bold;
        }

        .kod {
            width: 100%;
            height: auto;
            background-color: lightgrey;
            border: solid black 4px;
            font-family: 'Courier New', Courier, monospace;
            font-weight: bold;
        }
    </style>
</head>

<body>

    <div class="zadanie">
        <h2 class="tytul">ZADANIE 1:</h2>
        <form method="post" action="06.12.php">
            login:<input type="text" name="login" value="admin"><br>
            hasło:<input type="password" name="haslo"><br>
            <input type="submit" value="Prześlij">
        </form>
    </div>

    <?php
        // $login = "admin";
        // $haslo = "12345";

        // if($_POST["login"] !== $login or $_POST["haslo"] !== $haslo) {
        //     echo "<script>alert('Nieprawidłowe dane!')</script>";
        // }
        // else{
        //     echo "<script>alert('Poprawne dane!')</script>";
        // }
    ?>

    <div class="zadanie">
        <h2 class="tytul">DEFINIOWANIE STAŁYCH I STAŁYCH MAGICZNYCH:</h2>
        <h3>1. STAŁE:</h3>
        <div class="kod">
            <pre>
1   define("GREETING", "Welcome to W3Schools.com!");
2   echo GREETING;
            </pre>
        </div>
        <h3>2. STAŁE MAGICZNE:</h3>
        <ul>
            <li>__LINE__ - aktualny numer linii pliku</li>
            <li>__FILE__ - pełna ścieżka pliku</li>
            <li>__DIR__ - katalog pliku</li>
            <li>__FUNCTION__ - nazwa funkcji</li>
            <li>__CLASS__ - nazwa klasy</li>
            <li>__TRAIT__ - nazwa cechy</li>
            <li>__METHOD__ - nazwa metody klasy</li>
            <li>__NAMESPACE__ - nazwa przestrzeni nazw</li>
        </ul>
        <h3>3. Metody String</h3>
        <ul>
            <li>strlen("Hello World");</li>
            <!--długość stringa-->
            <li>str_word_count("Hello World a");</li>
            <!--ilość słów-->
            <li>strrev("Jacob");</li>
            <!--rewers stringa-->
            <li>strrev("Hello World", "world");</li>
            <!--miejsce wystąpienia ciągu znaków-->
            <li>str_replace("world", "Dolly czesc", "Hello World!");</li>
            <!--zamienia world na dolly-->
            <li>str_repeat(".", 10);</li>
            <!--zamienia world na dolly-->
            <li>lcfirst("HELLO world!");</li>
            <li>ucfirst("hello world!");</li>
            <li>strtoupper("Hello World!");</li>
            <!--str.toUpperCase()-->
            <li>strtolower("Hello World!");</li>
            <li>strcmp("Ala","Ala");</li>
            <!--zwraca 0 jeśłi takie same, jeśli różne zwraca -1 // ===, >, < -->
            <li>stristr("Hello world!", "lo");</li>
            <!--znajduje pierwsze wystąpienie szukanego ciągu znaków i od niego zwraca -->
            <li>substr("Hello world", 1, 3);</li>
            <li>str_repeat(".", 10);</li>
            <!--zamienia world na dolly-->
            <li>str_shuffle("Hello world!");</li>
            <!-- pomieszać stringa w JS: console.log('Hello world'.split('').sort(()=>0.5-Math.random()).join(''));-->
            <li>chr(51);</li>
            <!--decimal value-->
            <li>chr(051);</li>
            <!--octal value-->
            <li>chr(0x51);</li>
            <!--Hex value-->
            <li>crc32("Hello world!");</li>
            <!--32-bit CRC (cyclic redundancy checksum)-->
            <li>md5("12345");</li>
            <!--md5 checksum-->
        </ul>
    </div>

    <div class="zadanie">
        <h2 class="tytul">ZADANIE 2</h2>
        <p>Napisz skrypt który zapyta poprzez okno prompt o wartość z przedziału 0-3.
            Poprzez kod JS przekaż zmienną do PHP.
            W PHP przy pomocy switch sprawdź wartość tej zmiennej.
            W przypadku (case 1-3) wygeneruj liczby przy pomocy różnych pętli z zakresu od zmienna do 10.
            (np. w CASE 1 będziesz miał pętle FOR która generuje liczby od 1 do 10
            w CASE 2 będziesz miał pętle WHILE która generuje liczby od 2 do 10
            w CASE 3 będziesz miał pętle DO...WHILE która generuje liczby od 3 do 10)
            W przypadku (case 0) wyświetl alert:
            "Wpisałeś: 0.
            Nic nie robimy".
        </p>
        <!-- <script>
            let cyfra = prompt('Podaj cyfrę z zakresu 0-3:', '0');
            parseInt(cyfra);
            let href = (location.href)+"?cyfra="+cyfra;
            fetch(href);
            console.log(href);
        </script> -->
        <?php
        // $cyfra = $_GET["cyfra"];
        // $tab = [];

        // switch ($cyfra) {
        //     case 0:
        //         echo "<script>alert('Wpisałeś: 0. Nic nie robimy.')</script>";
        //         break;
        //     case 1:
        //         for ($i = 1; $i <= 10; $i++) {
        //             echo $cyfra . ",";
        //             $tab[$i] += $cyfra;
        //             $cyfra++;
        //         }
        //         echo "<script>alert('$tab')</script>";
        //         break;
        //     case 2:
        //         $i = 2;
        //         while ($i <= 10) {
        //             echo $cyfra . ",";
        //             $tab[$i] += $cyfra;
        //             $cyfra++;
        //         }
        //         echo "<script>alert('$tab')</script>";
        //         break;
        //     case 3:
        //         $i = 3;
        //         do {
        //             echo $cyfra . ",";
        //             $tab[$i] += $cyfra;
        //             $cyfra++;
        //         } while ($i <= 10);
        //         echo "<script>alert('$tab')</script>";
        //         break;
        // }
        ?>

        
    </div>

    <div class="zadanie">
            <h2>FUNKCJA WYPISUJĄCA LICZBY PODZIELNE PRZEZ 3 I 5</h2>
            <div id="podzielne"></div>
    </div>

    <?php
        function podzielne($x, $y) {
            for($i = 0; $i <= 100; $i++)
            {
                if($i % $x == 0 && $i % $y == 0)
                    continue;
                
                if($i % $x == 0)
                    echo "<script>document.getElementById('podzielne').innerHTML += ${i} + ', '</script>";
                
                if($i % $y == 0)
                    echo "<script>document.getElementById('podzielne').innerHTML += ${i} + ', '</script>";
            }
        }

        podzielne(3, 5);
    ?>

    <div class="zadanie">
            <h2>FUNKCJA WYPISUJĄCA TABLICZKĘ MNOŻENIA</h2>
            <div id="tabliczka"></div>
    </div>

    <?php 
        function tabliczka($x, $y) {
            for($i = 1; $i <= $x; $i++)
            {
                echo "<script>document.getElementById('tabliczka').innerHTML += ${i} + ' ';</script>";
                for($j = 2; $j <= $y; $j++)
                {
                    $a = $i * $j;
                    echo "<script>document.getElementById('tabliczka').innerHTML += ${a} + ' ';</script>";
                }
                echo "<script>document.getElementById('tabliczka').innerHTML += '<br>'</script>";
            }
        }

        tabliczka(10, 10);
    ?>

    <div class="zadanie">
            <h2>FUNKCJA SPRAWDZAJĄCA CZY LICZBA JEST PIERWSZA</h2>
            <div id="pierwsza"></div>
    </div>

    <?php 
        function pierwsza($x) {
            
            $pierwsza = true;
            for($i = 2; $i < $x; $i++)
            {
                if($pierwsza){
                    if($x % $i == 0) {
                        $pierwsza = false;
                    }
                 }
            }

            if($x <= 1)
            {
                echo "<script>document.getElementById('pierwsza').innerHTML += 'Liczba ${x} nie jest ani pierwsza ani złożona.'</script>";
            }
            elseif($pierwsza) {
                echo "<script>document.getElementById('pierwsza').innerHTML += 'Liczba ${x} jest pierwsza.'</script>";
            }
            else
            {
                echo "<script>document.getElementById('pierwsza').innerHTML += 'Liczba ${x} nie jest pierwsza.'</script>";
            }
        }

        pierwsza(4);
    ?>

    <div class="zadanie">
            <h2>FUNKCJA RYSUJĄCA CHOINKĘ Z GWIAZDEK</h2>
            <div id="choinka"></div>
    </div>

    <?php 
        function choinka($a) {
            $k = $a - 1;
            for($i = 1; $i <= $a; $i++)
            {
                for($j = $k; $j < $a; $j++)
                {
                    echo "<script>document.getElementById('choinka').innerHTML += '*'</script>";
                }
                $k -= 1;
                echo "<script>document.getElementById('choinka').innerHTML += '<br>'</script>";
            }
        }

        choinka(5);
    ?>

    <div class="zadanie">
            <h2>FUNKCJA SPRAWDZAJĄCA CZY WYRAZY PODANE W TABLICY ZNAJDUJĄ SIĘ W STRINGU I ZAMIENIAJĄCA JE NA _</h2>
            <div id="cenzura"></div>
    </div>

    <?php
        function porownaj($startString, $tabWords) {
            $ileWords = count($tabWords);
            $litery = str_split($startString);
            $ileLiter = count($litery);
            $word = "";
            $newWord = "";
            $endString = "";
    
            for($i = 0; $i < $ileLiter; $i++)
            {
                if($litery[$i] == " " || $i == array_key_last($litery))
                {
                    for($j = 0; $j < $ileWords; $j++)
                    {
                        if($word == $tabWords[$j])
                        {
                            foreach(str_split($word) as $x)
                            {
                                $x = "_";
                                $newWord .= $x;
                            }
                            $endString .= $newWord . " ";
                        }
                        break;
                    }
                    if($i != $ileLiter - 1)
                    {
                        $endString .= $word . " ";            
                    }
                    $word = "";
                }
                else{
                    $word .= $litery[$i];
                }
    
            }
    
            echo "<script>document.getElementById('cenzura').innerHTML +='".$endString."'</script>";
        }
        $tablica = ["Ala", "nie"];
        $string = "Ala ma kota."; 
        // porownaj($string, $tablica);
    ?>

    <div class="zadanie">
            <h2>DODAWANIE I USUWANIE PLIKÓW</h2>
            <div id="plik"></div>
            <div id="plik2"></div>
    </div>

    <?php
        // $plik = 'testowy2.txt';
        // if(is_file($plik))
        //     echo "<script>document.getElementById('plik').innerHTML +='".filesize($plik)."'</script>";
        // else
        // {
        //     echo "<script>document.getElementById('plik').innerHTML +='Nie ma takiego pliku!<br>'</script>";
        //     touch($plik);
        //     echo "<script>document.getElementById('plik').innerHTML +='Utworzono pomyślnie'</script>";
        // }
            
    
        // $plik2 = "test.txt";
        // if(is_file($plik2))
        // {
        //     unlink($plik2);
        //     echo "<script>document.getElementById('plik2').innerHTML +='Skasowano pomyślnie!'</script>";
        // }
        // else{
        //     touch($plik2);
        //     echo "<script>document.getElementById('plik2').innerHTML +='Utworzono pomyślnie!'</script>";
        // }
    ?>

    <div class="zadanie">
            <h2>CZAT ONLINE</h2>
            <form action="06.12.php" method="GET">
                Nick: <br>
                <input type="text" name="nick"><br>
                Message: <br>
                <textarea name="message"></textarea><br>
                <input type="submit" value="Wyślij">
            </form>
            <div id="chat">
                <?php 
                if(is_file("chat_history.txt") == true)
                    include("chat_history.txt")
                ?>
            </div>
    </div>

    <?php
            $nick = $_GET["nick"];
            $message = $_GET["message"];
            $data = date("H:m:s");

            if(empty($_GET["nick"]) != true and empty($_GET["message"]) != true)
            {   
                $file = "chat_history.txt";
                $post = "<br><table rules='none' width='350' border='2px solid black'>
                    <tr height='20'>
                        <td bgcolor='#f4f4f4' width='30%'>
                         <b>". $nick . "</b></td>
                        <td bgcolor='#d6d6d6' width='250'>".$message."</td>
                        <td align='center' bgcolor='#e3e3e3' width='20%'>".$data."</td>
                    </tr>
                </table>";

                $historyFile = fopen($file, "a+");
                fwrite($historyFile, $post);
                
                echo "<script>document.getElementById('chat').innerHTML += ".$post."</script>";
                unset($_GET["nick"], $_GET["message"]);

                fclose($historyFile);
            }
            else
            {
                echo "<script>alert('Nie wprowadzono wszystkich danych!')</script>";
            }

            
                        
    ?>

</body>

</html>