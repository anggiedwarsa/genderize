import 'dart:io';

String fixture(String name) {
  var currentDirectory = Directory.current.toString().replaceAll('\'', '');
  var lastDirectory =
      currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('fixtures/$name').readAsStringSync();
  } else {
    return File('test/fixtures/$name').readAsStringSync();
  }
}

File fromFile(String name) {
  var currentDirectory = Directory.current.toString().replaceAll('\'', '');
  var lastDirectory =
      currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('fixtures/$name');
  } else {
    return File('test/fixtures/$name');
  }
}
