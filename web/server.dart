import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('Serving on http://localhost:8080');
  print('Press Ctrl+C to stop');

  await for (final request in server) {
    final path = request.uri.path == '/' ? '/index.html' : request.uri.path;
    final file = File('web$path');
    
    if (await file.exists()) {
      final contentType = _getContentType(path);
      request.response.headers.contentType = ContentType(
        contentType[0],
        contentType[1],
        charset: 'utf-8',
      );
      await request.response.addStream(file.openRead());
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('404 Not Found');
    }
    await request.response.close();
  }
}

List<String> _getContentType(String path) {
  if (path.endsWith('.html')) return ['text', 'html'];
  if (path.endsWith('.js')) return ['application', 'javascript'];
  if (path.endsWith('.css')) return ['text', 'css'];
  if (path.endsWith('.png')) return ['image', 'png'];
  if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return ['image', 'jpeg'];
  if (path.endsWith('.gif')) return ['image', 'gif'];
  if (path.endsWith('.svg')) return ['image', 'svg+xml'];
  return ['application', 'octet-stream'];
}

