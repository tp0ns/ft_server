<!-- MySQL settings - You can get this info from your web host ** //
The name of the database for WordPress -->
<?php

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'user1' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_HOST', 'localhost' );

$table_prefix = 'wp_';

// define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}
require_once( ABSPATH . 'wp-settings.php' );
?>