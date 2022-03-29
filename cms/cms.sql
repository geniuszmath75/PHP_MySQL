-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 29 Mar 2022, 21:07
-- Wersja serwera: 10.4.22-MariaDB
-- Wersja PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `cms`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `fields`
--

INSERT INTO `fields` (`id`, `tid`, `name`, `type_id`) VALUES
(1, 1, 'Tytuł', 1),
(2, 1, 'Treść', 2),
(3, 3, 'css', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `field_types`
--

CREATE TABLE `field_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(100) NOT NULL,
  `php+html` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `field_types`
--

INSERT INTO `field_types` (`id`, `name`, `type`, `php+html`) VALUES
(1, 'input[type=text]', 'varchar(255)', '\'<input type=\"text\" name=\"\'. $x[0] .\'\" value=\"\'. @$x[1] .\'\"\'. @$x[2] .\'>\''),
(2, 'textarea', 'text', '\'<textarea name=\"\'. $x[0] .\'\"\'. @$x[2] .\'>\'. @$x[1] .\'</textarea>\''),
(3, 'checkbox', 'varchar(1)', '\'<input type=\"checkbox\" name=\"\'. $x[0] .\'\" value=\"1\"\'. ( @$x[1] ? \' checked\' : \'\' ) . @$x[2] .\'>\'');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `inserts`
--

CREATE TABLE `inserts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `php` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `inserts`
--

INSERT INTO `inserts` (`id`, `name`, `php`) VALUES
(1, 'admin_niezalogowany', 'if( isset( $_POST[\'p\'] ) )\r\n{\r\n    if( $_POST[\'p\'] == ADMIN_PASSWORD )\r\n    {\r\n        $_SESSION[\'admin\'] = 1;\r\n        redirect( \'Zalogowano!\', \'/admin\' );\r\n    }\r\n\r\n    $_SESSION[\'kom\'][] = \'Błędne hasło!\';\r\n}\r\n\r\nreturn [ \'body\' =>\r\n\r\n    \'<form action=\"\" method=\"post\">\'.\r\n        \'<input type=\"password\" name=\"p\" required>\'.\r\n        \'<input type=\"submit\" value=\"login\">\'.\r\n    \'</form>\'\r\n];'),
(2, 'admin_zalogowany', 'if( isset( $_GET[\'logout\'] ) ) { unset( $_SESSION[\'admin\'] ); redirect( \'Wylogowano\', \'admin\' ); }\r\n\r\n$modules = [ \'template\', \'inserts\', \'insert\', \'field_type\', \'field_types\' ];\r\n$module = @array_keys( $_GET )[0];\r\n$submodule = @array_keys( $_GET )[1];\r\n$action_links = [ \'edit\' => \'edytuj\', \'copy\' => \'kopiuj\', \'delete\" onclick=\"return confirm(`Na pewno?!`)\' => \'skasuj\' ];\r\n$actions = [ \'edit\', \'copy\', \'delete\' ];\r\n$action = @$_GET[\'action\'];\r\n$copy = $action == \'copy\';\r\n\r\nif( $module == \'template\' )\r\n{\r\n  $actions[] = \'fields\';\r\n  $actions[] = \'pages\';\r\n  if( $submodule == \'field\' ) $actions[] = \'order\';\r\n  if( $submodule == \'page\' ) $actions[] = \'view\';\r\n}\r\n\r\nelseif( ! in_array( $module, $modules ) ) { $module = \'templates\'; $action_links[\'pages\'] = \'strony\'; $action_links[\'fields\'] = \'pola\'; }\r\n\r\nif( ! in_array( $action, $actions ) || $copy ) $action = \'edit\';\r\n\r\n$r = eval( i( \"admin_$module\" ) );\r\n\r\n$r[\'body\'] = \'<p><a href=\"admin?logout\">wyloguj</a> | \'.\r\n             \'<a href=\"admin\">szablony</a> | \'.\r\n             \'<a href=\"admin?inserts\">wstawki</a> | \'.\r\n             \'<a href=\"admin?field_types\">typy pól</a></p>\'.\r\n             \'<hr>\'.\r\n             @$r[\'body\'];\r\n\r\nif( in_array( $module, [ \'templates\', \'inserts\', \'field_types\' ] ) || in_array( $action, [ \'fields\', \'pages\' ] ) )\r\n\r\n  @$r[\'css\'] .= \'td { padding: 10px; } tr:hover td { background: #ccc; } \';\r\n\r\nif( $action == \'edit\' )\r\n\r\n  @$r[\'css\'] .= \'input[type=text], textarea { width: 100%; background: #fff; padding: 3px; } \'.\r\n                \'textarea { resize: vertical; height: 500px; } \';\r\nreturn $r;'),
(3, 'admin_inserts', '$items = sql( \'SELECT `id`,`name` FROM `inserts` ORDER BY `name`\' );\r\n\r\n$href = \'insert\';\r\n$caption = \'Wstawki\';\r\n$czego = \'wstawek\';\r\n\r\n$body = \'<a href=\"admin?insert\">utwórz wstawkę</a>\';\r\n\r\nreturn [ \'body\' => eval( i( \'admin_list\' ) ) ];'),
(4, 'admin_insert', 'if( $id = @$_GET[\'insert\'] )\r\n{\r\n  if( ! $insert = f( \'SELECT * FROM `inserts` WHERE `id`=?\', $id ) )\r\n\r\n    redirect( \'Nie ma takiej wstawki!\', \'admin?inserts\' );\r\n}\r\nelse\r\n{\r\n  $insert = [ $id = 0, \'\', \'\' ];\r\n  $action = \'edit\';\r\n}\r\n\r\n$name = trim( $_POST[\'name\'] ?? $insert[1] ?? \'\' );\r\n$safe_name = htmlspecialchars( $name );\r\n$php = trim( $_POST[\'php\'] ?? $insert[2] ?? \'\' );\r\n\r\nreturn eval( i( \"admin_insert_$action\" ) );'),
(5, 'admin_insert_edit', 'if( count( $_POST ) )\r\n{\r\n  if( $copy ) $id = 0;\r\n\r\n  if( ! strlen( $name ) ) $_SESSION[\'kom\'][] = \'Nazwa wstawki nie może być pusta!\';\r\n\r\n  elseif( sql( \"SELECT 1 FROM `inserts` WHERE `name`=? AND `id`!=$id\", $name )->rowCount() )\r\n\r\n    $_SESSION[\'kom\'][] = \'Istnieje już wstawka o podanej nazwie!\';\r\n\r\n  if( ! strlen( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP wstawki nie może być pusty!\';\r\n\r\n  elseif( $e = check_php( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP wstawki zawiera błąd składni w linii \'. $e->getLine() .\':<br>\'. $e->getMessage();\r\n\r\n  if( ! isset( $_SESSION[\'kom\'] ) )\r\n  {\r\n    $q = sql( $id ? \"UPDATE `inserts` SET `name`=?,`php`=? WHERE `id`=$id\"\r\n                  : \'INSERT INTO `inserts` SET `name`=?, `php`=?\',\r\n              [ $name, $php ] );\r\n\r\n    if( $q ) redirect( \"Wstawka \'$safe_name\' została \". ( $id ? \'zaktualizowana\' : \'utworzona\' ), \'/admin?inserts\' );\r\n\r\n    $_SESSION[\'kom\'][] = \'Coś poszło nie tak przy \'. ( $id ? \'edycji\' : \'dodawaniu\' ) .\" wstawki: $safe_name\";\r\n  }\r\n}\r\n\r\nreturn [ \'body\' => \'<h1>\'. ( $id ? ( $copy ? \'Kopia\' : \'Edycja\' ) .\" wstawki: $safe_name\" : \'Nowa wstawka\' ).\'</h1>\'.\r\n\r\n  \'<form action=\"\" method=\"post\">\'.\r\n    \'<p><b>Nazwa</b>:<br><input type=\"text\" name=\"name\" value=\"\'. $safe_name .\'\" required></p>\'.\r\n    \'<p><b>Kod PHP</b>:<br><textarea name=\"php\" required autofocus>\'. htmlspecialchars( $php ) .\'</textarea></p>\'.\r\n    \'<p><input type=\"submit\" value=\"zapisz\"></p>\'.\r\n  \'</form>\'\r\n];'),
(6, 'admin_insert_delete', 'sql( \"DELETE from `inserts` WHERE `id`=$id\" );\r\nsql( \"ALTER TABLE `inserts` AUTO_INCREMENT=1\" );\r\n\r\nredirect( \"Wstawka \'$safe_name\' usunięta\", \'admin?inserts\' );'),
(7, 'admin_templates', '$items = sql( \'SELECT `id`,`name` FROM `templates` ORDER BY `name`\' );\r\n\r\n$href = \"template\";\r\n$caption = \'Szablony\';\r\n$czego = \'szablonów\';\r\n\r\n$body = \'<a href=\"admin?template\">utwórz szablon</a>\';\r\n\r\nreturn [ \'body\' => eval( i( \'admin_list\' ) ) ];'),
(8, 'admin_template', 'if( $tid = @$_GET[\'template\'] )\r\n{\r\n  if( ! $template = f( \'SELECT * FROM `templates` WHERE `id`=?\', $tid ) ) redirect( \'Nie ma takiego szablonu!\', \'admin\' );\r\n}\r\nelse { $template = [ $tid = 0, \'\', \'\', \'\' ]; $action = \'edit\'; }\r\n\r\n$name = trim( $_POST[\'name\'] ?? $template[1] );\r\n$safe_name = htmlspecialchars( $name );\r\n$php = trim( $_POST[\'php\'] ?? $template[2] );\r\n\r\nif( in_array( $submodule, [ \'field\', \'page\' ] ) ) $s = \"admin?template=$tid&action={$submodule}s\";\r\n\r\nelse { $submodule = $action; if( $action == \'pages\' ) $action_links[ \'view\" target=\"_blank\' ] = \'podgląd\'; }\r\n\r\n$r = eval( i( \"admin_template_$submodule\" ) );\r\n\r\n$r[\'body\'] = ( $tid ? \"<h1>Szablon: $safe_name</h1>\".\r\n\r\n  implode( \' | \', array_map( function($x) use($tid) { return \"<a href=\\\"admin?template=$tid&$x\"; },\r\n\r\n    [ \'page\">utwórz stronę</a>\', \'field\">utwórz pole</a>\', \'action=pages\">strony</a>\', \'action=fields\">pola</a>\', \'\">edytuj szablon</a>\' ]\r\n\r\n  ) ) : \'\' ) . ( $r[\'body\'] ?? \"<p>Błąd w: admin_template_$submodule</p>\" );\r\n\r\nreturn $r;'),
(9, 'admin_template_edit', 'function fields( $tid, $o = 0 ) { return sql( \"SELECT * FROM `fields` WHERE `tid`=$tid ORDER BY \".( $o ? \"FIELD(id,$o)\" : \'id\' ) ); }\r\n\r\nif( count( $_POST ) )\r\n{\r\n  if( $copy ) { $old_tid = $tid; $tid = 0; }\r\n\r\n  if( ! strlen( $name ) ) $_SESSION[\'kom\'][] = \'Nazwa szablonu nie może być pusta!\';\r\n\r\n  elseif( sql( \"SELECT 1 FROM `templates` WHERE `name`=? AND `id`!=$tid\", $name )->rowCount() )\r\n\r\n    $_SESSION[\'kom\'][] = \'Istnieje już szablon o podanej nazwie!\';\r\n\r\n  if( ! strlen( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP szablonu nie może być pusty!\';\r\n\r\n  elseif( $e = check_php( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP szablonu zawiera błąd składni w linii \'. $e->getLine() .\':<br>\'. $e->getMessage();\r\n\r\n  if( ! isset( $_SESSION[\'kom\'] ) )\r\n  {\r\n    $q = sql( $tid ? \"UPDATE `templates` SET `name`=?,`php`=? where `id`=$tid\"\r\n                   : \'INSERT INTO `templates` SET `name`=?,`php`=?\',\r\n              [ $name, $php ] );\r\n    if( $q )\r\n    {\r\n      if( ! $tid )\r\n      {\r\n        $new_tid = sql()->lastInsertId();\r\n        $q = sql( \"CREATE TABLE `pages_$new_tid` ( `id` int(11) NOT NULL UNIQUE KEY, \".\r\n                  \'FOREIGN KEY (`id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ) DEFAULT CHARSET=utf8\' );\r\n\r\n        if( $copy )\r\n        {\r\n          $field_types = eval( i( \'field_types\' ) );\r\n          if( ( $fields = fields( $old_tid, $template[3] ) )->rowCount() )\r\n          {\r\n            $field_order = [];\r\n\r\n            while( $f = fetch( $fields ) )\r\n            {\r\n              sql( \'INSERT INTO `fields` SET `name`=?,`type_id`=?,`tid`=?\', [ $f[2], $f[3], $new_tid ] );\r\n              $field_order[] = $new_fid = sql()->lastInsertId();\r\n              sql( \"ALTER TABLE `pages_$new_tid` ADD `f_$new_fid` \". $field_types[ $f[3] ][1] .\" COLLATE \'utf8_general_ci\' NOT NULL\" );\r\n            }\r\n\r\n            sql( \"UPDATE `templates` SET `field_order`=? WHERE `id`=$new_tid\", implode( \',\', $field_order ) );\r\n          }\r\n        }\r\n      }\r\n\r\n      redirect( \"Szablon \'$safe_name\'\".( $copy ? \' wraz z polami\' : \'\' ).\" został \". ( $tid ? \'zaktualizowany\' : \'utworzony\' ), \'/admin\' );\r\n    }\r\n\r\n    if( ! $q ) $_SESSION[\'kom\'][] = \'Coś poszło nie tak przy \'. ( $tid ? \'edycji\' : \'dodawaniu\' ) .\" szablonu: $safe_name\";\r\n  }\r\n}\r\n\r\n$fields = fields( $tid ); $fields_list = \'\'; $i = 0;\r\nwhile( $f = fetch( $fields ) ) { $i++; $fields_list .= \'<tr><th>\'. htmlspecialchars( $f[2] ) .\"</th><th>F[$i]</th></tr>\"; }\r\n\r\nreturn [ \'body\' => \'<h1>\'.( $tid ? ( $copy ? \'Kopia\' : \'Edycja\' ) : \'Nowy szablon\' ).\'</h1>\'.\r\n\r\n  ( $fields_list ? \'<h3>Pola</h3><table border cellpadding=\"3\" cellspacing=\"0\">\'. $fields_list .\'</table>\' : \'\' ).\r\n\r\n  \'<form action=\"\" method=\"post\">\'.\r\n    \'<p><b>Nazwa</b>:<br><input type=\"text\" name=\"name\" value=\"\'. $safe_name .\'\" required></p>\'.\r\n    \'<p><b>Kod PHP</b>:<br><textarea name=\"php\" required autofocus>\'. htmlspecialchars( $php ) .\'</textarea></p>\'.\r\n    \'<p><input type=\"submit\" value=\"zapisz\"></p>\'.\r\n  \'</form>\'\r\n];'),
(10, 'admin_template_delete', 'sql( \"DROP TABLE `pages_$tid`\" );\r\nsql( \"DELETE FROM `templates` WHERE `id`=$tid\" );\r\nsql( \"ALTER TABLE `templates` AUTO_INCREMENT=1\" );\r\nsql( \"ALTER TABLE `fields`    AUTO_INCREMENT=1\" );\r\nsql( \"ALTER TABLE `pages`     AUTO_INCREMENT=1\" );\r\n\r\nredirect( \"Szablon \\\"$safe_name\\\" wraz ze stronami usunięty\", \'/admin\' );'),
(11, 'admin_template_fields', '$items = sql( \"SELECT `id`,`name` FROM `fields` WHERE `tid`=$tid\".( ( $o = $template[3] ) ? \" ORDER BY FIELD(id,$o)\" : \'\' ) );\r\n\r\n$href = \"template=$tid&field\";\r\n$caption = \'Pola\';\r\n$czego = \'pól\';\r\n\r\nreturn [ \'body\' => eval( i( \'admin_list\' ) ) ];'),
(12, 'admin_template_pages', '$items = sql( \"SELECT `id`,`url` FROM `pages` WHERE `tid`=$tid\" );\r\n\r\n$href = \"template=$tid&page\";\r\n$caption = \"Strony\";\r\n$czego = \"stron\";\r\n\r\nreturn [ \'body\' => eval( i( \'admin_list\' ) ) ];'),
(13, 'admin_template_field', 'if( strlen( $fid = @$_GET[\'field\'] ) )\r\n{\r\n  if( ! $field = f( \"SELECT * FROM `fields` WHERE `tid`=$tid AND `id`=?\", $fid ) ) redirect( \'Nie ma takiego pola!\', $s );\r\n}\r\nelse { $field = [ $fid = 0, $tid, \'\', 0 ]; $action = $actions[0]; }\r\n\r\n$safe_field_name = htmlspecialchars( $field_name = trim( $_POST[\'name\'] ?? $field[2] ) );\r\n\r\nreturn eval( i( \"admin_field_$action\" ) );'),
(14, 'admin_field_edit', '$type_id = $_POST[\'type_id\'] ?? $field[3];\r\n\r\n$field_types = eval( i( \'field_types\' ) );\r\n\r\nif( count( $_POST ) )\r\n{\r\n  if( $copy ) $fid = 0;\r\n\r\n  if( ! strlen( $name ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Nazwa pola nie może być pusta!\';\r\n\r\n  elseif( sql( \"SELECT 1 FROM `fields` WHERE `tid`=? AND `name`=? AND `id`!=$fid\", [ $tid, $name ] )->rowCount() )\r\n\r\n    $_SESSION[\'kom\'][] = \'Istnieje już w tym szablonie pole o podanej nazwie!\';\r\n\r\n  elseif( ! isset( $field_types[ $type_id ] ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Błędny typ pola!\';\r\n\r\n  if( ! isset( $_SESSION[\'kom\'] ) )\r\n  {\r\n    if( $fid )\r\n    {    \r\n      if( $q = sql( \'UPDATE `fields` SET `name`=?,`type_id`=? WHERE `id`=?\', [ $name, $type_id, $fid ] ) )\r\n        $q = sql( \"ALTER TABLE `pages_$tid` CHANGE `f_$fid` `f_$fid` \". $field_types[$type_id][1] .\' NOT NULL\' );\r\n    }\r\n    elseif( $q = sql( \'INSERT INTO `fields` SET `name`=?,`type_id`=?,`tid`=?\', [ $name , $type_id, $tid ] ) )\r\n    {\r\n      $new_fid = sql()->lastInsertId();\r\n      if( $q = sql( \"ALTER TABLE `pages_$tid` ADD `f_$new_fid` \". $field_types[$type_id][1] .\' NOT NULL\' ) )\r\n      {\r\n        $field_order = explode( \',\', $template[3] );\r\n\r\n        if( $field_order[0] ) $field_order[] = $new_fid;\r\n        else $field_order = [ $new_fid ];\r\n\r\n        $q = sql( \'UPDATE `templates` SET `field_order`=? WHERE `id`=?\', [ implode( \',\', $field_order ), $tid ] );\r\n      }\r\n    }\r\n\r\n    if( $q ) redirect( \"Pole \'$safe_field_name\' zostało \". ( $fid ? \'zaktualizowane\' : \'utworzone\' ), $s );\r\n\r\n    $_SESSION[\'kom\'][] = \'Coś poszło nie tak przy \'. ( $new ? \'dodawaniu\' : \'edycji\' ) .\" pola: $safe_field_name\";\r\n  }\r\n}\r\n\r\n$l = \"<a href=\\\"admin?template=$tid&\";\r\n\r\nreturn [ \'body\' => \'<h1>\'.( $fid ? ( $copy ? \'Kopia\' : \'Edycja\' ) .\" pola: $safe_field_name\" : \'Nowe pole\' ).\'</h1>\'.\r\n\r\n  \'<form action=\"\" method=\"post\">\'.\r\n    \'<p><b>Nazwa</b>:<br><input type=\"text\" name=\"name\" value=\"\'. $safe_field_name .\'\" required></p>\'.\r\n    \'<p><b>Typ pola</b>:<select name=\"type_id\" required>\'. implode( array_map( function($x,$y) use( $type_id ) { return \'<option value=\"\'. $x .\'\"\'.( $type_id == $x ? \' selected\' : \'\' ).\'>\'. htmlspecialchars( $y[0] ) .\'</option>\'; }, array_keys( $field_types ), array_values( $field_types ) ) ) .\'</select></p>\'.\r\n    \'<p><input type=\"submit\" value=\"zapisz\"></p>\'.\r\n    \'</form>\'\r\n];'),
(15, 'admin_field_delete', 'sql( \"DELETE FROM `fields` WHERE `id`=$fid\" );\r\nsql( \"ALTER TABLE `fields` AUTO_INCREMENT=1\" );\r\nsql( \"ALTER TABLE `pages_$tid` DROP `f_$fid`\" );\r\nsql( \'UPDATE `templates` SET `field_order`=? WHERE `id`=?\', [ implode( \',\', array_diff( explode( \',\', $template[3] ), [ $fid ] ) ), $tid ] );\r\n\r\nredirect( \"Pole \'$safe_field_name\' zostało usunięte. Zaktualizuj w szablonie odwołania do pól\", \"/admin?template=$tid\" );'),
(16, 'admin_template_page', 'if( strlen( $pid = @$_GET[\'page\'] ) )\r\n{\r\n  if( ! $page = f( \"SELECT * FROM `pages` WHERE `tid`=$tid AND `id`=?\", $pid ) ) redirect( \'Nie ma takiej strony!\', $s );\r\n}\r\nelse { $page = [ $pid = 0, $tid, \'\' ]; $action = \'edit\'; }\r\n\r\n$safe_url = htmlspecialchars( $url = trim( $_POST[\'url\'] ?? $page[2] ) );\r\n\r\nreturn eval( i( \"admin_page_$action\" ) );'),
(17, 'admin_page_edit', '$safe_url = htmlspecialchars( $url = trim( $_POST[ \'url\' ] ?? $page[2] ) );\r\n\r\nif( count( $_POST ) )\r\n{\r\n  if( $copy ) $pid = 0;\r\n\r\n  if( sql( \"SELECT 1 FROM `pages` WHERE `url`=? AND `id`!=$pid\", $url )->rowCount() ) $_SESSION[\'kom\'][] = \'Istnieje już strona o podanym adresie!\';\r\n\r\n  else\r\n  {\r\n    if( $q = sql( $pid ? \'UPDATE `pages` SET `url`=? WHERE `id`=\'. $pid : \'INSERT INTO `pages` SET `url`=?, `tid`=\'. $tid, [ $url ] ) )\r\n    {\r\n      if( ! $pid ) $q = sql( \"INSERT INTO `pages_$tid` SET `id`=\". ( $new_pid = sql()->lastInsertId() ) );\r\n\r\n      if( $q && ( $fields = sql( \"SELECT * FROM `fields` WHERE `tid`=$tid\" ) )->rowCount() )\r\n      {\r\n        $p = $d = []; while( $f = fetch( $fields ) ) { $p[] = \"`f_$f[0]`=?\"; $d[] = $_POST[ \"f_$f[0]\" ] ?? \'\'; }\r\n        $q = sql( \"UPDATE `pages_$tid` SET \". implode( \',\', $p ) .\' WHERE `id`=\'. ( $pid ?: $new_pid ), $d );\r\n      }\r\n\r\n      if( $q ) redirect( \"Strona \'$safe_url\' została \". ( $pid ? \'zaktualizowana\' : \'utworzona\' ), $s );\r\n    }\r\n\r\n    $_SESSION[\'kom\'][] = \'Coś poszło nie tak przy \'. ( $pid ? \'edycji\' : \'dodawaniu\' ) .\" strony: $safe_url\";\r\n  }\r\n}\r\nelseif( $pid ) $data = sql( \"SELECT * FROM `pages_$tid` WHERE `id`=$pid\" )->fetch( PDO::FETCH_ASSOC );\r\n\r\n$form_fields = \'\';\r\n$field_types = eval( i( \'field_types\' ) );\r\n$fields = sql( \"SELECT * FROM `fields` WHERE `tid`=$tid\".( ( $o = $template[3] ) ? \" ORDER BY FIELD(id,$o)\" : \'\' ) );\r\n\r\nwhile( $f = fetch( $fields ) )\r\n{\r\n  $x = [ \"f_$f[0]\", htmlspecialchars( trim( $_POST[ \"f_$f[0]\" ] ?? $data[ \"f_$f[0]\" ] ?? \'\' ) ), \'\' ];\r\n  $form_fields .= \'<p><b>\'. htmlspecialchars( $f[2] ) .\'</b>:<br>\'. eval( \'return \'. $field_types[ $f[3] ][2] .\';\' ) .\'</p>\';\r\n}\r\n\r\n$l = \"<a href=\\\"admin?template=$tid&\";\r\n\r\nreturn [ \'body\' => \'<h1>\'.( $pid ? ( $copy ? \'Kopia\' : \'Edycja\' ) .\" strony: $safe_url\" : \'Nowa strona\' ).\'</h1>\'.\r\n\r\n  \'<form action=\"\" method=\"post\">\'.\r\n    \'<p><b>URL</b>:<br><input type=\"text\" name=\"url\" value=\"\'. $safe_url .\'\"></p>\'.\r\n    $form_fields.\r\n    \'<p><input type=\"submit\" value=\"zapisz\"></p>\'.\r\n    \'</form>\'\r\n];'),
(18, 'admin_page_delete', 'sql( \"DELETE from `pages_$tid` WHERE `id`=$pid\" );\r\nsql( \"DELETE from `pages` WHERE `id`=$pid\" );\r\nsql( \"ALTER TABLE `pages` AUTO_INCREMENT=1\" );\r\n\r\nredirect( \"Wstawka \\\"$safe_name\\\" usunięta\", $s );'),
(19, 'admin_field_types', '$items = sql( \'SELECT `id`,`name` FROM `field_types` ORDER BY `name`\' );\r\n\r\n$href = \'field_type\';\r\n$caption = \'Typy pól\';\r\n$czego = \'typów pól\';\r\n\r\n$body = \'<a href=\"admin?field_type\">utwórz typ pola</a>\';\r\n\r\nreturn [ \'body\' => eval( i( \'admin_list\' ) ) ];'),
(20, 'admin_field_type', 'if( strlen( $id = @$_GET[\'field_type\'] ) )\r\n{\r\n  if( ! $field_type = f( \'SELECT * FROM `field_types` WHERE `id`=?\', $id ) )\r\n\r\n    redirect( \'Nie ma takiego typu pola!\', \'admin?field_types\' );\r\n}\r\nelse\r\n{\r\n  $field_type = [ $id = 0, \'\', \'\', \'\' ];\r\n  $action = $actions[0];\r\n}\r\n\r\n$name = trim( $_POST[\'name\'] ?? $field_type[1] );\r\n$safe_name = htmlspecialchars( $name );\r\n$type = trim( $_POST[\'type\'] ?? $field_type[2] );\r\n$php = trim( $_POST[\'php\'] ?? $field_type[3] );\r\n\r\nreturn eval( i( \"admin_field_type_$action\" ) );'),
(21, 'admin_field_type_edit', 'if( count( $_POST ) )\r\n{\r\n  if( $copy ) $id = 0;\r\n\r\n  if( ! strlen( $name ) ) $_SESSION[\'kom\'][] = \'Nazwa typu pola nie może być pusta!\';\r\n\r\n  elseif( sql( \"SELECT 1 FROM `field_types` WHERE `name`=? AND `id`!=$id\", $name )->rowCount() )\r\n\r\n    $_SESSION[\'kom\'][] = \'Istnieje już typ pola o podanej nazwie!\';\r\n\r\n  if( ! strlen( $type ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Typ MySQL typu pola nie może być pusty!\';\r\n\r\n  if( ! strlen( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP typu pola nie może być pusty!\';\r\n\r\n  elseif( $e = check_php( $php ) )\r\n\r\n    $_SESSION[\'kom\'][] = \'Kod PHP typu pola zawiera błąd składni w linii \'. $e->getLine() .\':<br>\'. $e->getMessage();\r\n\r\n  if( ! isset( $_SESSION[\'kom\'] ) )\r\n  {\r\n    $q = sql( $id ? \"UPDATE `field_types` SET `name`=?,`type`=?,`php+html`=? WHERE `id`=$id\"\r\n                  : \'INSERT INTO `field_types` SET `name`=?,`type`=?,`php+html`=?\',\r\n              [ $name, $type, $php ] );\r\n\r\n    if( $q )\r\n    {\r\n      if( ( $q = sql( \"SELECT `id`,`tid` FROM `fields` WHERE `type_id`=$id\" ) )->rowCount() )\r\n      {\r\n        while( list( $ft_id, $ft_tid ) = fetch( $q ) )\r\n\r\n          sql( \"ALTER TABLE `pages_$ft_tid` CHANGE `f_$ft_id` `f_$ft_id` $type NOT NULL\" );\r\n      }\r\n\r\n      redirect( \"Typ pola \'$safe_name\' został \". ( $id ? \'zaktualizowany\' : \'utworzony\' ), \'/admin?field_types\' );\r\n    }\r\n\r\n    $_SESSION[\'kom\'][] = \'Coś poszło nie tak przy \'. ( $id ? \'edycji\' : \'dodawaniu\' ) .\" typu pola: $safe_name\";\r\n  }\r\n}\r\n\r\nreturn [ \'body\' => \'<h1>\'.( $id ? ( $copy ? \'Kopia\' : \'Edycja\' ) .\" typu pola: $safe_name\" : \'Nowy typ pola\' ).\'</h1>\'.\r\n\r\n  \'<form action=\"\" method=\"post\">\'.\r\n    \'<p><b>Nazwa</b>:<br><input type=\"text\" name=\"name\" value=\"\'. $safe_name .\'\" required></p>\'.\r\n    \'<p><b>Typ MySQL</b>:<br><input type=\"text\" name=\"type\" value=\"\'. htmlspecialchars( $type ) .\'\" required></p>\'.\r\n    \'<p><b>Kod PHP+HTML</b>:<textarea name=\"php\" required autofocus>\'. htmlspecialchars( $php ) .\'</textarea></p>\'.\r\n    \'<p><input type=\"submit\" value=\"zapisz\"></p>\'.\r\n  \'</form>\'\r\n];'),
(22, 'admin_field_type_delete', 'sql( \"DELETE from `field_types` WHERE `id`=$id\" );\r\nsql( \"ALTER TABLE `field_types` AUTO_INCREMENT=1\" );\r\n\r\nredirect( \"Typ pola \'$safe_name\' został usunięty\", \'admin?field_types\' );'),
(23, 'field_types', '$q = sql( \"SELECT * FROM `field_types`\" );\r\n\r\n$ft = [];\r\n\r\nwhile( $x = fetch( $q ) )\r\n\r\n  $ft[ $x[0] ] = array_slice( $x, 1 );\r\n\r\nreturn $ft;'),
(24, 'admin_list', 'if( $ile = $items->rowCount() )\r\n{\r\n  @$body .= \"<h1>$caption</h1><table>\";\r\n\r\n  $i = 0;\r\n\r\n  while( $x = fetch( $items ) )\r\n  {\r\n    $body .= \'<tr><td><b>\'. htmlspecialchars( $x[1] ) .\'</b></td><td>\';\r\n\r\n    $links = [];\r\n\r\n    foreach( $action_links as $k => $v ) $links[] = \"<a href=\\\"admin?$href=$x[0]&action=$k\\\">$v</a>\";\r\n\r\n    if( $caption == \'Pola\' && $ile > 1 ) $links[] = \"<a href=\\\"admin?$href=$x[0]&action=order\\\">\". ( $i++ ? \'▲\' : \'▼\' ) .\'</a>\';\r\n\r\n    $body .= implode( \' | \', $links ) .\'</td></tr>\';\r\n  }\r\n\r\n  $body .= \'</table>\';\r\n}\r\nelse $body = \"<h1>Brak $czego</h1> <p>\". @$body .\'</p>\';\r\n\r\nreturn $body;'),
(25, 'admin_page_view', '$url = f( \"SELECT `url` FROM `pages` WHERE `id`=$pid\" );\r\n\r\nredirect( null, \"/$url\" );'),
(26, 'admin_field_order', '$o = explode( \',\', $template[3] );\r\n\r\nif( count( $o ) < 2 ) redirect( \'Niedozwolona operacja\', $s );\r\n\r\nif( $a = array_search( $fid, $o ) ) $a--;\r\n\r\nlist( $o[ $a+1 ], $o[ $a ] ) = array_slice( $o, $a, 2 );\r\n\r\nsql( \'UPDATE `templates` SET `field_order`=? WHERE `id`=?\', [ implode( \',\', $o ), $tid ] );\r\n\r\nredirect( \"Pozycja pola \'$safe_field_name\' została zmieniona\", $s );');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pages`
--

INSERT INTO `pages` (`id`, `tid`, `url`) VALUES
(1, 1, ''),
(2, 2, 'admin'),
(3, 1, 'testowa'),
(4, 3, 'logowanie'),
(5, 3, 'logowanie2'),
(6, 3, 'logowanie3');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pages_1`
--

CREATE TABLE `pages_1` (
  `id` int(11) NOT NULL,
  `f_1` varchar(100) NOT NULL,
  `f_2` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pages_1`
--

INSERT INTO `pages_1` (`id`, `f_1`, `f_2`) VALUES
(1, 'Strona główna', 'Witaj na stronie wygenerowanej dynamicznie przez CMS<br>\r\n(Content Managment System - System zarządzania treścią).<br><br>\r\n\r\nDziała on w oparciu o technologie: HTML, CSS, JS, PHP i MySQL.<br><br>\r\n\r\nDo swojej pracy wymaga jedynie 3 plików:<br>\r\n- index.php - silnik CMS\'a,<br>\r\n- .htaccess - przekierowania URL,<br>\r\n- polacz_z_baza.php - połączenie z bazą danych.<br><br>\r\n\r\ni danych przechowywanych w bazie danych MySQL.<br><br>\r\n\r\nŻyczę Ci wygodnej i przyjemnej w nim pracy - autor.'),
(3, 'Testowa', 'Strona demonstruje użycie funkcji zdefiniowanych w silniku <b>index.php</b>.<br><br>\r\n\r\nNa potrzeby tej strony wyobraź sobie, że istnieje tabela `test` z kolumnami: `id`, `abc` i `xyz` oraz dwoma rekordami:<br>\r\n1, 0123456789, abcdefghijklmnopqrstuvwxyz<br>\r\n2, qwerty, 12345<br><br>\r\n\r\nZałóżmy, że chcemy pobrać wartość \"qwerty\" następującym zapytaniem:<br>\r\n<b><i>$q = \'SELECT `abc` FROM `test` WHERE `id`=2\';</i></b><br><br>\r\n\r\nWywołanie funkcji <b><i>sql()</i></b> zwraca obiekt klasy PDO połączenia z bazą danych,<br>\r\nna którym można wywoływać standardowe metody, np.:<br><br>\r\n\r\n<b><i>$a = sql()->query( $q );</i></b><br><br>\r\n\r\nale można prościej: <b><i>$a = sql( $q );</i></b><br><br>\r\n\r\na zamiast \"bezpiecznego\" zapytania:<br><br>\r\n\r\n<b><i>$a = sql()->prepare( \'SELECT `abc` FROM `test` WHERE `id`=?\' );<br>\r\n$a->execute( [ 2 ] );</i></b><br><br>\r\n\r\nmożna prościej: <b><i>$a = sql( \'SELECT `abc` FROM `test` WHERE `id`=?\', 2 );</i></b><br><br>\r\n\r\nprzy czym jeśli bindujemy jedną wartość, to nie bierzemy jej w nawiasy kwadratowe.<br><br>\r\n\r\nWywołanie <b><i>fetch( $a )</i></b> jest skrótem do <b><i>$a->fetch( PDO::FETCH_NUM )</i></b><br><br>\r\n\r\ni zwróci - dla ułatwienia - łańcuch \"qwerty\", a nie tablicę, gdyż pobieramy wartość tylko jednego pola.<br><br>\r\n\r\nJeśli z góry wiemy, że pobieramy jeden rekord, możemy zamiast:<br>\r\n<b><i>fetch( sql( ... ) )</i></b> użyć skrótu: <b><i>f( ... )</i></b>.<br><br>\r\n\r\nTen CMS pozwala na gromadzenie tzw. \"wstawek\", do których treści można się odwoływać po nazwie, w następujący sposób:<br><br>\r\n\r\n<b><i>i( \'admin_zalogowany\' );</i></b><br><br>\r\n\r\nDo dyspozycji mamy również funkcję <b><i>redirect(...)</i></b>,<br>\r\nktóra służy do wywołania przekierowania pod inny adres URL wraz z przekazaniem w ramach sesji php jakiejś treści/komunikatu.<br>\r\nKomunikat podajemy w pierwszym argumencie, a adres URL - w drugim, przy czym:<br>\r\n- jeśli adres nie zaczyna się od znaku /, to traktowany jest adres względny,<br>\r\n- jeśli zaś adres zaczyna się od znaku /, traktowany jest, jak adres względem folderu ROOT tego CMS\'a.<br><br>\r\n\r\nW celu wyświetlenia w/w komunikatu korzystamy z funkcji <b><i>kom()</i></b>,<br>\r\nktóra zwraca tablicę asocjacyjną z dwoma polami: \"body\" i \"css\" ] na potrzeby wklejenia w odpowiednie miejsca szablonu.<br><br>\r\n\r\nCzęsto w tym CMS\'ie zachodzi potrzeba sprawdzenia poprawności składni php w badanym ciągu znaków, np. we wstawkach.<br>\r\nWówczas wystarczy skorzystać z funkcji <b><i>check_php( ... )</i></b>, która w razie wykrycia błędu, zwraca obiekt wyjątku ParseError, z którego można odczytać m.in. informacje o typie błędu czy numer linii kodu, która wywołała w/w wyjątek.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pages_2`
--

CREATE TABLE `pages_2` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pages_2`
--

INSERT INTO `pages_2` (`id`) VALUES
(2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pages_3`
--

CREATE TABLE `pages_3` (
  `id` int(11) NOT NULL,
  `f_3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pages_3`
--

INSERT INTO `pages_3` (`id`, `f_3`) VALUES
(4, 'body {\r\n    font-size: 15px;\r\n    background-color: aquamarine;\r\n    font-family: \'Ropa Soft\';\r\n}\r\n\r\n#loginPanel {\r\n    background-color: #fff;\r\n    width: 26.7em;\r\n    padding: 2.7em 3.3em;\r\n    margin-left: auto;\r\n    margin-right: auto;\r\n    margin-top: 0.7em;\r\n    box-shadow: 3px 3px 30px 5px rgba(204,204,204,0.9);\r\n}\r\n\r\nh1 {\r\n    text-align: center;\r\n}\r\n\r\n#loginInput, #passw {\r\n    width: 20em;\r\n    background-color: #efefef;\r\n    color: #666;\r\n    border: 2px solid #ddd;\r\n    border-radius: 5px;\r\n    font-size:1.3em;\r\n    padding: 0.6em;\r\n    box-sizing: border-box;\r\n    outline: none;\r\n    margin-top: 0.2em;\r\n    margin-bottom: 0.7em;\r\n}\r\n\r\n#loginInput:focus,\r\n#passw:focus {\r\n    box-shadow: 0 0 10px 2px rgba(204,204,204,0.9);\r\n    background-color: #e9f3e9;\r\n    color: #428c42;\r\n}\r\n\r\n#log {\r\n    width: 20em;\r\n    background-color: #36b03c;\r\n    font-size: 1.3em;\r\n    color: #fff;\r\n    padding: 0.9em 0.5em;\r\n    cursor: pointer;\r\n    margin-top: 0.7em;\r\n    border: none;\r\n    border-radius: 5px;\r\n    letter-spacing: 2px;\r\n    outline: none;\r\n}\r\n\r\n#log:focus {\r\n    box-shadow: 0 0 15px 5px rgba(204,204,204,0.9);\r\n}\r\n\r\n#log:hover {\r\n    background-color: #37b93d;\r\n}\r\n\r\n.nazwa {\r\n    text-align: center;\r\n    margin: auto;\r\n    font-size: 1.5em;\r\n    margin: 2px;\r\n}\r\n\r\n#title {\r\n    text-align: center;\r\n    font-weight: 400;\r\n    letter-spacing: 2px;\r\n    font-size: 2.3em;\r\n    font-family: \'Lobster\', cursive;\r\n    margin-top: 0;\r\n    margin-bottom: 1.3em;\r\n}\r\n\r\np {\r\n    text-align: center;\r\n    font-weight: bold;\r\n}'),
(5, 'body {\r\n    font-size: 15px;\r\n    background-color: yellowgreen;\r\n    font-family: \'Helvetica\', sans-serif;\r\n}\r\n\r\n#loginPanel {\r\n    background-color: #baf;\r\n    width: 26.7em;\r\n    padding: 2.7em 3.3em;\r\n    margin-left: auto;\r\n    margin-right: auto;\r\n    margin-top: 0.7em;\r\n    box-shadow: 3px 3px 30px 5px rgba(204,204,204,0.9);\r\n}\r\n\r\nh1 {\r\n    text-align: center;\r\n}\r\n\r\n#loginInput, #passw {\r\n    width: 20em;\r\n    background-color: #efefef;\r\n    color: #fff;\r\n    border: 2px solid #ddd;\r\n    border-radius: 5px;\r\n    font-size:1.3em;\r\n    padding: 0.6em;\r\n    box-sizing: border-box;\r\n    outline: none;\r\n    margin-top: 0.2em;\r\n    margin-bottom: 0.7em;\r\n}\r\n\r\n#loginInput:focus,\r\n#passw:focus {\r\n    box-shadow: 0 0 10px 2px rgba(204,204,204,0.9);\r\n    background-color: #87a387;\r\n    color: #2c9c77;\r\n}\r\n\r\n#log {\r\n    width: 200px;\r\n    background-color: #f00;\r\n    font-size: 1.5em;\r\n    font-weight: bold;\r\n    color: #000;\r\n    padding: 1em 0.3em;\r\n    cursor: pointer;\r\n    margin-left: 100px;\r\n    margin-right: 100px;\r\n    margin-top: 0.7em;\r\n    border: none;\r\n    border-radius: 5px;\r\n    letter-spacing: 1.5px;\r\n    outline: none;\r\n}\r\n\r\n#log:focus {\r\n    box-shadow: 0 0 15px 5px rgba(204,204,204,0.9);\r\n}\r\n\r\n#log:hover {\r\n    background-color: #ddd;\r\n}\r\n\r\n.nazwa {\r\n    text-align: center;\r\n    margin: auto;\r\n    font-size: 1.5em;\r\n    margin: 2px;\r\n}\r\n\r\n#title {\r\n    text-align: center;\r\n    font-weight: 500;\r\n    letter-spacing: 3px;\r\n    font-size: 2.3em;\r\n    font-family: \'Banthers\';\r\n    margin-top: 0;\r\n    margin-bottom: 1.3em;\r\n}\r\n\r\np {\r\n    text-align: center;\r\n    font-weight: bold;\r\n}'),
(6, 'body {\r\n    font-size: 15px;\r\n    background-color: slategrey;\r\n    font-family: \'Segoe UI\';\r\n}\r\n\r\n#loginPanel {\r\n    background-color: #d59d53;\r\n    width: 26.7em;\r\n    padding: 2.7em 3.3em;\r\n    margin-left: auto;\r\n    margin-right: auto;\r\n    margin-top: 0.7em;\r\n    box-shadow: 3px 3px 30px 5px rgba(200,200,175,0.9);\r\n}\r\n\r\nh1 {\r\n    text-align: center;\r\n}\r\n\r\n#loginInput, #passw {\r\n    width: 20em;\r\n    background-color: #9ff99f;\r\n    color: #fff;\r\n    border: 2px solid #ddd;\r\n    border-radius: 5px;\r\n    font-size:1.3em;\r\n    padding: 0.6em;\r\n    box-sizing: border-box;\r\n    outline: none;\r\n    margin-top: 0.2em;\r\n    margin-bottom: 0.7em;\r\n}\r\n\r\n#loginInput:focus,\r\n#passw:focus {\r\n    box-shadow: 0 0 10px 2px rgba(200,200,175,0.9);\r\n    background-color: #6ff66f;\r\n    color: #2c9c77;\r\n}\r\n\r\n#log {\r\n    width: 250px;\r\n    background-color: #44f;\r\n    font-size: 1.5em;\r\n    font-weight: bold;\r\n    color: #444;\r\n    padding: 1em 0.3em;\r\n    cursor: pointer;\r\n    margin-left: 75px;\r\n    margin-right: 75px;\r\n    margin-top: 0.7em;\r\n    border: none;\r\n    border-radius: 5px;\r\n    letter-spacing: 1.5px;\r\n    outline: none;\r\n}\r\n\r\n@keyframes btnHover {\r\n    0% { background-color: #44f; }\r\n    100%{ background-color: #def; }\r\n}\r\n\r\n#log:focus {\r\n    box-shadow: 0 0 15px 5px rgba(200,200,175,0.9);\r\n}\r\n\r\n#log:hover {\r\n    animation: btnHover 1s ease forwards;\r\n}\r\n\r\n.nazwa {\r\n    text-align: center;\r\n    margin: auto;\r\n    font-size: 1.5em;\r\n    margin: 2px;\r\n}\r\n\r\n#title {\r\n    text-align: center;\r\n    font-weight: 500;\r\n    letter-spacing: 3px;\r\n    font-size: 2.3em;\r\n    font-family: \'Lucida Sans\';\r\n    margin-top: 0;\r\n    margin-bottom: 1.3em;\r\n}\r\n\r\np {\r\n    text-align: center;\r\n    font-weight: bold;\r\n}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `templates`
--

CREATE TABLE `templates` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `php` text NOT NULL,
  `field_order` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `templates`
--

INSERT INTO `templates` (`id`, `name`, `php`, `field_order`) VALUES
(1, 'simple', '$kom = kom();\r\n\r\n$title = htmlspecialchars( F[1] );\r\n\r\ndie(\r\n\r\n\'<!DOCTYPE html>\'.\r\n\'<html>\'.\r\n    \'<head>\'.\r\n        \'<meta charset=\"utf-8\">\'.\r\n        \"<title>$title</title>\".\r\n        \'<base href=\"\'. ROOT .\'\">\'.\r\n        \'<style>\'.\r\n\r\n            \'html :not(head) { box-sizing: border-box; font-family: Verdana; } \'.\r\n            \'body { margin: 25px; padding: 0; background: #e0e0e0; } \'.\r\n\r\n            @$kom[\'css\'].\r\n\r\n        \'</style>\'.\r\n    \'</head>\'.\r\n    \'<body>\'.\r\n\r\n        \'<nav> <a href=\"\">Home</a> | <a href=\"admin\">Admin</a> </nav>\'.\r\n\r\n        @$kom[\'body\'].\r\n\r\n        \"<h1>$title</h1>\".\r\n        \'<p>\'. F[2] .\'</p>\'.\r\n\r\n    \'</body>\'.\r\n\'</html>\'\r\n\r\n);', '2,1'),
(2, 'admin', '$f = eval( i( \'admin_\'. ( isset( $_SESSION[\'admin\'] ) ? \'\' : \'nie\' ) .\'zalogowany\' ) );\r\n\r\n$kom = kom();\r\n\r\necho\r\n\r\n\'<!DOCTYPE html>\'.\r\n\'<html>\'.\r\n    \'<head>\'.\r\n        \'<title>Zaplecze administracyjne</title>\'.\r\n        \'<meta charset=\"utf-8\">\'.\r\n        \'<base href=\"\'. ROOT .\'\">\'.\r\n        \'<style>\'.\r\n\r\n            \'html * { box-sizing: border-box; font-family: Verdana; } \'.\r\n            \'body { margin: 25px; padding: 0; background: #e0e0e0; } \'.\r\n            \'@font-face { font-family: DejaVu; src: url(\'.ROOT.\'/fonts/DejaVuSansMono.ttf); } \'.\r\n            \'textarea { font-family: DejaVu; } \'.\r\n\r\n            @$f[\'css\'] . @$kom[\'css\'].\r\n\r\n        \'</style>\'.\r\n\r\n        @$f[\'links\'].\r\n\r\n    \'</head>\'.\r\n    \'<body>\'.\r\n\r\n        \'<h1>Zaplecze administracyjne</h1>\'.\r\n\r\n        @$kom[\'body\'] . @$f[\'body\'].\r\n\r\n        ( ( $js = @$kom[\'js\'] . @$f[\'js\'] ) ? \"<script>$js</script>\" : \'\' ).\r\n\r\n        @$f[\'scripts\'].\r\n\r\n    \'</body>\'.\r\n\'</html>\';', ''),
(3, 'Formularz logowania', 'echo \"<!DOCTYPE html>\r\n<html lang=\'pl\'>\r\n\r\n<head>\r\n    <meta charset=\'UTF-8\'>\r\n    <meta http-equiv=\'X-UA-Compatible\' content=\'IE=edge\'>\r\n    <meta name=\'viewport\' content=\'width=device-width, initial-scale=1.0\'>\r\n    <title>Logowanie</title>\r\n    <style>\";\r\n            echo F[1];\r\n\r\n    echo \"</style>\r\n</head>\r\n\r\n<body>\r\n    <div id=\'loginPanel\'>\r\n        <div id=\'title\'>\r\n            <h1>Logowanie</h1>\r\n        </div>\r\n        <form method=\'POST\'>\r\n            <div id=\'login\'>\r\n                <label for=\'logins\'>\r\n                    <span class=\'nazwa\'>\r\n                        <p>Login</p>\r\n                    </span>\r\n                </label>\r\n                <span>\r\n                    <input type=\'text\' id=\'loginInput\' name=\'login\' placeholder=\'Podaj login...\'>\r\n                </span>\r\n            </div>\r\n            <div id=\'haslo\'>\r\n                <label for=\'haslos\'>\r\n                    <span class=\'nazwa\'>\r\n                        <p>Hasło</p>\r\n                    </span>\r\n                </label>\r\n                <span>\r\n                    <input type=\'password\' id=\'passw\' name\'haslo\' placeholder=\'Podaj hasło...\'><br>\r\n                </span>\r\n            </div>\r\n            <div id=\'submit\'>\r\n                <span>\r\n                    <input type=\'submit\' value=\'Zaloguj się\' id=\'log\'>\r\n                </span>\r\n            </div>\r\n        </form>\r\n    </div>\r\n</body>\r\n\r\n</html>\";', '3');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid_name` (`tid`,`name`),
  ADD KEY `type_id` (`type_id`);

--
-- Indeksy dla tabeli `field_types`
--
ALTER TABLE `field_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `inserts`
--
ALTER TABLE `inserts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`) USING HASH,
  ADD KEY `tid` (`tid`);

--
-- Indeksy dla tabeli `pages_1`
--
ALTER TABLE `pages_1`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeksy dla tabeli `pages_2`
--
ALTER TABLE `pages_2`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeksy dla tabeli `pages_3`
--
ALTER TABLE `pages_3`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeksy dla tabeli `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `field_types`
--
ALTER TABLE `field_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `inserts`
--
ALTER TABLE `inserts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT dla tabeli `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `fields`
--
ALTER TABLE `fields`
  ADD CONSTRAINT `fields_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fields_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `field_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `pages_1`
--
ALTER TABLE `pages_1`
  ADD CONSTRAINT `pages_1_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `pages_2`
--
ALTER TABLE `pages_2`
  ADD CONSTRAINT `pages_2_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `pages_3`
--
ALTER TABLE `pages_3`
  ADD CONSTRAINT `pages_3_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
