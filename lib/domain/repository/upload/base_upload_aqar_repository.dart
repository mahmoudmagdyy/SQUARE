import '/index.dart';

abstract class BaseUploadAqarRepository {
  ResultFuture<List<CityEntity>> getCities();
  ResultFuture<List<AreaEntity>> getTypesAqar();
  ResultFuture<List<InnerQuestionsEntity>> getQuestions();
  ResultFuture<List<InnerQuestionsEntity>> getExtraOptions();
  ResultFuture<void> upload(UploadParameter uploadParameter);
}
