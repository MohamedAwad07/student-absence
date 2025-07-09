class AppRoutes {
  static const String splash = '/splash';
  static const String authGate = '/authGate';
  static const String loginWelcome = '/loginWelcome';
  static const String login = '/login/:role';
  static const String register = '/register';

  // student routes
  static const String studentHome = '/StudentHome';
  static const String studentTrackExcuses = '/StudentTrackExcuses';
  static const String studentAddExcuses = '/StudentAddExcuses';
  static const String studentNotifications = '/StudentNotifications';
  static const String studentProfilePage = '/StudentProfilePage';

  // supervisor routes
  static const String supervisorHome = '/SupervisorHome';
  static const String supervisorExcuseDetails = '/SupervisorExcuseDetails';
  static const String supervisorRevisedExcuses = '/SupervisorRevisedExcuses';
  static const String supervisorNotifications = '/SupervisorNotifications';
  static const String supervisorProfilePage = '/SupervisorProfilePage';

  // Manager routes

  static const String managerHome = '/ManagerHome';
  static const String managerRevisedExcuses = '/ManagerRevisedExcuses';
  static const String managerExcuseDetails = '/ManagerExcuseDetails';
  static const String managerNotifications = '/ManagerNotifications';
  static const String managerProfilePage = '/ManagerProfilePage';
}
