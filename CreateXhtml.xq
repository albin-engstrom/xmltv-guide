xquery version "1.0";
declare default element namespace 'http://www.w3.org/1999/xhtml';

let $source_doc := fn:doc("http://tecfa.unige.ch/guides/xml/examples/shakespeare.1.10.xml/hamlet.xml")

return

(: The html tag :)
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Tv Guide</title>
	</head>

	<body>
		<p>Hello World!</p>
	</body>
</html>
