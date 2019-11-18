<?php
$dbHost = $_ENV["DB_HOST"];
$dbPort = $_ENV['DB_PORT'];
$dbName = $_ENV["DB_NAME"];
$dbUser = $_ENV["DB_USER"];
$dbPass = $_ENV['DB_PASS'];
$redisHost = $_ENV['REDIS_HOST'];
$redisPort = $_ENV['REDIS_PORT'];
$dsn = "mysql:host=$dbHost;port=$dbPort;dbname=$dbName";
$options = [
PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
PDO::ATTR_EMULATE_PREPARES => false,
];
try {
$pdo = new PDO($dsn, $dbUser, $dbPass, $options);
} catch (\PDOException $e) {
throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
$stmt = $pdo->query('SELECT name FROM users');
while ($row = $stmt->fetch()) {
echo $row['name'] . "\n";
}
$redis = new Redis();
$redis->connect($redisHost, $redisPort);
echo "Server is running: " . $redis->ping();
