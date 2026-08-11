// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:test_romankaygo/app/di/register_module.dart' as _i153;
import 'package:test_romankaygo/features/documents/data/database/app_database.dart'
    as _i830;
import 'package:test_romankaygo/features/documents/data/database/daos/document_dao.dart'
    as _i912;
import 'package:test_romankaygo/features/documents/data/repositories/document_repository_impl.dart'
    as _i205;
import 'package:test_romankaygo/features/documents/data/services/document_import_service_impl.dart'
    as _i300;
import 'package:test_romankaygo/features/documents/data/services/pdf_builder_service.dart'
    as _i329;
import 'package:test_romankaygo/features/documents/data/services/pdf_preview_service.dart'
    as _i215;
import 'package:test_romankaygo/features/documents/domain/repositories/document_repository.dart'
    as _i428;
import 'package:test_romankaygo/features/documents/domain/services/document_import_service.dart'
    as _i387;
import 'package:test_romankaygo/features/documents/domain/use_cases/add_document.dart'
    as _i82;
import 'package:test_romankaygo/features/documents/domain/use_cases/delete_documents.dart'
    as _i958;
import 'package:test_romankaygo/features/documents/domain/use_cases/get_documents.dart'
    as _i358;
import 'package:test_romankaygo/features/documents/domain/use_cases/search_documents.dart'
    as _i159;
import 'package:test_romankaygo/features/documents/domain/use_cases/toggle_document_status.dart'
    as _i134;
import 'package:test_romankaygo/features/documents/presentation/bloc/document_list_bloc.dart'
    as _i232;
import 'package:uuid/uuid.dart' as _i706;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i706.Uuid>(() => registerModule.uuid);
    gh.lazySingleton<_i830.AppDatabase>(() => _i830.AppDatabase());
    gh.lazySingleton<_i329.PdfBuilderService>(() => _i329.PdfBuilderService());
    gh.lazySingleton<_i215.PdfPreviewService>(() => _i215.PdfPreviewService());
    gh.lazySingleton<_i912.DocumentDao>(
      () => _i912.DocumentDao(gh<_i830.AppDatabase>()),
    );
    gh.lazySingleton<_i428.DocumentRepository>(
      () => _i205.DocumentRepositoryImpl(gh<_i912.DocumentDao>()),
    );
    gh.lazySingleton<_i387.DocumentImportService>(
      () => _i300.DocumentImportServiceImpl(
        gh<_i428.DocumentRepository>(),
        gh<_i329.PdfBuilderService>(),
        gh<_i215.PdfPreviewService>(),
        gh<_i183.ImagePicker>(),
        gh<_i706.Uuid>(),
      ),
    );
    gh.factory<_i958.DeleteDocuments>(
      () => _i958.DeleteDocuments(gh<_i428.DocumentRepository>()),
    );
    gh.factory<_i358.GetDocuments>(
      () => _i358.GetDocuments(gh<_i428.DocumentRepository>()),
    );
    gh.factory<_i159.SearchDocuments>(
      () => _i159.SearchDocuments(gh<_i428.DocumentRepository>()),
    );
    gh.factory<_i134.ToggleDocumentStatus>(
      () => _i134.ToggleDocumentStatus(gh<_i428.DocumentRepository>()),
    );
    gh.factory<_i82.AddDocument>(
      () => _i82.AddDocument(gh<_i387.DocumentImportService>()),
    );
    gh.factory<_i232.DocumentListBloc>(
      () => _i232.DocumentListBloc(
        getDocuments: gh<_i358.GetDocuments>(),
        addDocument: gh<_i82.AddDocument>(),
        deleteDocuments: gh<_i958.DeleteDocuments>(),
        searchDocuments: gh<_i159.SearchDocuments>(),
        toggleDocumentStatus: gh<_i134.ToggleDocumentStatus>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i153.RegisterModule {}
