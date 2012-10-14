<?php

header("Content-type: text/html; charset=utf8")

?>
<!DOCTYPE html>
<html>
<head>
<script src="http://cloud.github.com/downloads/processing-js/processing-js/processing-1.4.1.min.js"></script>
<link href='http://fonts.googleapis.com/css?family=Muli' rel='stylesheet' type='text/css'>
<style>
html {
	background-color: #222226;
	color: white;
	font-family: 'Muli', sans-serif;
}

canvas {
	width: 800px;
	height: 600px;
	background-color: black;
/*	border: 10px #777 solid;*/
}

article {
	margin: auto;
	width: 800px;
	padding: 20px;
}

header h1 {
	margin: 0;
	padding: 0;
	font-size: 96px;
	font-weight: bold;
}
header h2 {
	margin: -24px 0 0 0;
	padding: 0 0 0 12px;
}
h2 {
	font-size: 24px;
	margin: 12px 0;
}

p {
	font-size: 12px;
	margin: 12px 0;
}

</style>
</head>

<body>
	<header>
		<h1>100 Fomulae</h1>
		<h2>100 Days of Procedural Design</h2>
	</header>

	<article>
		<h1>Day 1: 14 October 2012</h1>
		<canvas data-processing-sources="processing/1.pde"></canvas>
		<p>On this site I will be producing one new procedural design, every day, for 100 days. A programmer by
			nature, some of this is familiar to me and some is new.</p>
		<p> &mdash; Sam Minnée</p>
	</article>
</body>
</html>