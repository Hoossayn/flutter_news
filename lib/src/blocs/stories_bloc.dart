import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc{
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemFetcher = PublishSubject<int>();



  //Getter to Stream
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //Getter to sink
  Function(int) get fetchItem => _itemFetcher.sink.add;


  StoriesBloc(){
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }


  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache(){
    return _repository.clearCache();
  }
  _itemTransformer(){
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index){
          print(index);
          cache[id] = _repository.fetchItems(id);
          return cache;
        },
      <int, Future<ItemModel>> {},
    );
  }
  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemFetcher.close();
  }
}