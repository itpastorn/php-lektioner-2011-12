<?php
/**
 * Inloggning med lösenordskontroll
 *
 * kolla_pw.php
 */

// 1. Initiera miljön
$mysqldb   = 'blogg';
$mysqluser = 'php_demo_user';
$mysqlpass = 'bad_pw';
$errortext = '';

// 2. Läs in, testa och "tvätta" användarens indata
if ( empty($_POST['username']) ) {
    $errortext .= "FEL";
}
if ( empty($_POST['username']) ) {
    $errortext = "FEL";
}


// 3. Anslut till DB
$dbh = new PDO('mysql:host=localhost;dbname=' . $mysqldb, $mysqluser, $mysqlpass);
$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$dbh->query("SET NAMES 'utf8' COLLATE 'utf8_swedish_ci'");

// 4. Förbered "statement" och bind variabler till platshållare
    $stmt = $dbh->prepare(
        "SELECT * FROM artiklar WHERE artiklarID = :id"
    );
    $stmt->bindParam(":id", $id);
    
    // 5. Utför
    $stmt->execute();
    
    // 6. Kolla om vi fick ett vettigt svar
    $svar = $stmt->fetch(PDO::FETCH_ASSOC);
    // var_dump($svar); // en array eller false
    if ( !$svar ) {
        $errortext = "Det sökta inlägget finns inte.";
    }
}

// echo $errortext;

// 7a. Felmeddelande
// 7b. Visa svaret

// inlagg.php?blogg=1

if ( $errortext ) {
    header("HTTP/1.1 404 Not Found");
    $text = $rubrik = $errortext;
} else {
    $rubrik = $svar['artiklar_rubrik'];
    $text   = $svar['artiklar_text'];
}
header("Content-type: text/html; charset=utf-8");
echo <<<HTML
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="utf-8" />
  <title>Gunthers blogg</title><!-- skall varieras -->
  <style>
  </style>
</head>
<body>
  <h1>{$rubrik}</h1>
  <div class="text">
    {$text}
  </div>
</body>
</html>
HTML;




