Router.route '/',
  name: 'home',
  controller: 'HomeController'
Router.route '/login',
  name: 'login',
  controller: 'LoginController'
Router.route '/torrents',
  name: 'torrents',
  controller: 'TorrentsController'
Router.route '/folder-files/:folderId',
  name: 'folderFiles',
  controller: 'FolderFilesController'
