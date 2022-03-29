<?php

abstract class CMS_PDO // klasa obsługująca komunikację z bazą danych
{
	private static $pdo;

	static function pdo( $query = null, $data = null )
	{
		try
		{
			if( ! CMS_PDO::$pdo )
			{
				CMS_PDO::$pdo = new PDO( 'mysql:host=localhost;encoding=utf8;dbname=cms', 'root', '',
					[ PDO::MYSQL_ATTR_FOUND_ROWS => true ] );
				CMS_PDO::$pdo -> query( 'SET CHARSET utf8' ); CMS_PDO::$pdo -> query( 'SET NAMES utf8 COLLATE utf8_bin' );
				CMS_PDO::$pdo -> setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
			}

			if( $data !== null ) ( $r = CMS_PDO::$pdo -> prepare( $query ) )->execute( is_array( $data ) ? $data : [ $data ] );
			else $r = $query ? CMS_PDO::$pdo -> query( $query ) : CMS_PDO::$pdo;

			return $r;
		}
		catch ( PDOException $e )
		{
			file_put_contents( __DIR__.'/logs/'.time().'.txt', $query .' | '. print_r( $data, 1 ) ."\n", FILE_APPEND );

			die( 'Błąd połączenia z bazą danych!<br>'. $e->getMessage() );
		}
	}
}

function sql( ...$a ) { return CMS_PDO::pdo( ...$a ); }