import 'package:get/get.dart';
import 'package:ixora_assignment/api/provider/get_photos_provider.dart';



class PhotoRepository extends GetxService {
  final PhotoProvider _profileProvider = Get.find();

  Future getAllPhotoListRepository(int pageNumber,int listLength,int connectionType){
    return _profileProvider.getAllPhotoListProvider(pageNumber,listLength,connectionType);
  }

  Future getAllPhotoListFromHiveRepository(){
    return _profileProvider.getAllPhotoListProviderFromHive();
  }
}