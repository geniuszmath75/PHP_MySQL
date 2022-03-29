<?php error_reporting(E_ALL); ini_set( 'display_errors', 1 ); date_default_timezone_set('Europe/Warsaw'); session_start();

define( 'ADMIN_PASSWORD', 'admin123#' );
define( 'DOMENA', @$_SERVER['HTTP_HOST'] );
define( 'SERWIS', 'https://' . DOMENA );
define( 'ROOT', rtrim( dirname( $_SERVER['PHP_SELF'] ), '/' ) .'/' );
define( 'URL', rtrim( substr( parse_url( urldecode( @$_SERVER['REQUEST_URI'] ), PHP_URL_PATH ), strlen( ROOT ) ), '/' ) );

require( 'polacz_z_baza.php' ); # -> sql( $query = null, $data = mix )

function fetch( $pre ) { return ( false === $f = $pre->fetch( PDO::FETCH_NUM ) ) ? false : ( count($f) == 1 ? $f[0] : $f ); }

function f( ...$f ) { return fetch( sql( ...$f ) ); }

function i( $i ) { return f( 'SELECT `php` FROM `inserts` WHERE `name`=? LIMIT 1', $i ); }

function redirect( $kom, $url = '' ) { if( $url[0] == '/' ) $url = ROOT . substr( $url, 1 ); $_SESSION['kom'][] = $kom; header( "Location: $url" ); exit; }

function kom() { if( ! $kom = @$_SESSION['kom'] ) return []; unset( $_SESSION['kom'] );
	return [ 'body' => '<h3 class="kom">'. implode( '<br>', $kom ) .'</h3>', 'css' => '.kom { color: red; }' ]; }

function check_php( $code ) { try { eval( "function() { $code; };" ); } catch( ParseError $e ) { return $e; } }

if( ! $p = f( 'SELECT `id`,`tid` FROM `pages` WHERE `url`=?', URL ) )
{ if( ! URL ) { $_SESSION = []; die('Strona w budowie'); }; redirect( 'Nie ma takiej strony!', '/' ); }

define( 'F', f( "SELECT * FROM `pages_$p[1]` WHERE `id`=$p[0]" ) );

eval( f( "SELECT `php` FROM `templates` WHERE `id`=$p[1]" ) );