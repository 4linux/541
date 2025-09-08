<?php

session_start();
if(isset($_SESSION['auth'])) {
	header('Location: index.php');
	exit;
}

$username = '';
if(isset($_POST['username'])) {

	$uri = getenv('DB_HOST') . ':' . getenv('DB_PORT');
	try {
		mysqli_report(MYSQLI_REPORT_STRICT);
		$mysql = new mysqli($uri, getenv('DB_USER'), getenv('DB_PASS'), getenv('DB_NAME'));
	} catch (Exception $ex) {
		echo 'Problemas ao se conectar com o banco:<br />' . PHP_EOL . $ex->getMessage();
		exit;
	}

	try {
		$username = $mysql->real_escape_string($_POST['username']);
		$pass = $_POST['pass'];
		$res = $mysql->query("SELECT * FROM usuarios WHERE email = '$username'");
		if(!$res)
			throw new Exception($mysql->error);
		$rs = $res->fetch_assoc();
		if($rs) {
			if(password_verify($pass, $rs['senha'])) {
				$_SESSION['auth'] = $rs['nome'];
				header('Location: index.php');
				exit;
			}
		}
	} catch (Exception $ex) {
		echo 'Problemas ao consultar o banco:<br />' . PHP_EOL . $ex->getMessage();
		exit;
	}
	$error = 'Usuário ou senha inválidos';
}

$ip = exec("hostname -i");

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login - Microservi&ccedil;o</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
	<div class="limiter">
		<?php if(isset($error)): ?>
		<div class="alert alert-danger" role="alert">
			<?=$error?>
		</div>
		<?php endif ?>
		<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
			<div class="wrap-login100">
				<form class="login100-form validate-form" method="post">
					<span class="login100-form-logo">
						<i class="zmdi zmdi-landscape"></i>
					</span>

					<span class="login100-form-title p-b-34 p-t-27">
						Log in
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Enter username">
						<input class="input100" type="text" name="username" placeholder="Username" value="<?=$username?>">
						<span class="focus-input100" data-placeholder="&#xf207;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="pass" placeholder="Password">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>

					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Login
						</button>
					</div>

					<div class="text-center p-t-10">
						<a class="txt1" href="/logout.php">
							<?=gethostname() . ' - ' . $ip?>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<script src="js/main.js"></script>
</body>
</html>
