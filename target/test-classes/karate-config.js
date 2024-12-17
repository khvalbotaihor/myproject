function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'ihorkhvalbota@gmail.com'
    config.userPassword = 'sabato2024'
  }
  if (env == 'qa') {
    config.userEmail = 'user@userok.com'
    config.userPassword = 'user12345678'  }

    var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
    karate.configure('headers', {Authorization: 'Token ' + accessToken}
    )
  return config;
}