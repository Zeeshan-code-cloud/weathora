class WeatherExceptions implements Exception
{

  final String errorMessage;

  WeatherExceptions(this.errorMessage);

  @override
  String toString() {
    // TODO: implement toString
    return errorMessage;
  }
}
class NetworkException extends WeatherExceptions {
    NetworkException(super.message);
}

class ServerException extends WeatherExceptions {
    ServerException(super.message);
}

class DataParsingException extends WeatherExceptions {
    DataParsingException(super.message);
}