enum AuthResultStatus {
  successful,
  bookAppointmentSuccess,
  updateAppointmentSuccess,
  rescheduleAppointmentSuccess,
  complateAppointmentSuccess,
  rateAppointmentSuccess,
  initPaymentSuccess,
  phoneVerified,
  emailAlreadyExists,
  mobileNumberAlreadyExists,
  mobileNumberNotRegistered,
  wrongPassword,
  invalidEmail,
  userNotFound,
  firebaseUserNull,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  apiConnectionError,
  undefined,
  cancelledByUser,
  facebookConnectionError,
  pleaseLoginFirst,
  weakPassword,
  requiresRecentLogin,
  zipCodeNotFound,
  getTokenFailed,
  bookAppointmentFailed,
  updateAppointmentFailed,
  rescheduleAppointmentFailed,
  complateAppointmentFailed,
  rateAppointmentFailed,
  initPaymentFailed,
  confirmPaymentFailed,
  createChannelFailed,
  kFailedToRecoverAuthError,
  kUserRecoverableAuthError,
  kSignInRequiredError,
  kSignInCanceledError,
  kNetworkError,
  kSignInFailedError
}

enum UserProfileStatus {
  completed,
  dateOfBirth,
  idNumber,
  mobileNumber,
  gender,
  country,
  maritalStatus,
  religion,
  ethnic,
  profession,
  lastEducation,
  questionnaire,
}

class AuthExceptionHandler {
  static AuthResultStatus handleException(e) {
    AuthResultStatus status = AuthResultStatus.undefined;
    try {
      if (e.code != null) {
        print(e.code);

        switch (e.code) {
          case "invalid-email":
            status = AuthResultStatus.invalidEmail;
            break;
          case "wrong-password":
            status = AuthResultStatus.wrongPassword;
            break;
          case "user-not-found":
            status = AuthResultStatus.userNotFound;
            break;
          case "user-disabled":
            status = AuthResultStatus.userDisabled;
            break;
          case "too-many-requests":
            status = AuthResultStatus.tooManyRequests;
            break;
          case "operation-not-allowed":
            status = AuthResultStatus.operationNotAllowed;
            break;
          case "email-already-exists":
            status = AuthResultStatus.emailAlreadyExists;
            break;
          case "requires-recent-login":
            status = AuthResultStatus.requiresRecentLogin;
            break;
          case "weak-password":
            status = AuthResultStatus.weakPassword;
            break;
          default:
            status = AuthResultStatus.undefined;
        }
      }
    } catch (error) {
      // if error does not contain a definition for 'code'
    }

    return status;
  }

  static AuthResultStatus googleException(e) {
    AuthResultStatus status = AuthResultStatus.undefined;

    switch (e) {
      case 'failed_to_recover_auth':
        status = AuthResultStatus.kFailedToRecoverAuthError;
        break;
      case 'user_recoverable_auth':
        status = AuthResultStatus.kUserRecoverableAuthError;
        break;
      case 'sign_in_required':
        status = AuthResultStatus.kSignInRequiredError;
        break;
      case 'sign_in_canceled':
        status = AuthResultStatus.kSignInCanceledError;
        break;
      case 'network_error':
        status = AuthResultStatus.kNetworkError;
        break;
      case 'sign_in_failed':
        status = AuthResultStatus.kSignInFailedError;
        break;
    }

    return status;
  }

  //
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.requiresRecentLogin:
        errorMessage = "Please reload this app";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.mobileNumberAlreadyExists:
        errorMessage = "The mobile number has already been registered.";
        break;
      case AuthResultStatus.mobileNumberNotRegistered:
        errorMessage = "Mobile number not registered! Please register first.";
        break;
      case AuthResultStatus.apiConnectionError:
        errorMessage = "Can't connect to server. Please try again later";
        break;
      case AuthResultStatus.cancelledByUser:
        errorMessage = "Cancelled by user.";
        break;
      case AuthResultStatus.facebookConnectionError:
        errorMessage = "Facebook connection error";
        break;
      case AuthResultStatus.pleaseLoginFirst:
        errorMessage = "Please login first";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "Password too weak";
        break;
      case AuthResultStatus.zipCodeNotFound:
        errorMessage = "Zip code not found";
        break;
      case AuthResultStatus.bookAppointmentSuccess:
        errorMessage = "Booking appointment success";
        break;
      case AuthResultStatus.updateAppointmentSuccess:
        errorMessage = "Update appointment success";
        break;
      case AuthResultStatus.rescheduleAppointmentSuccess:
        errorMessage = "Reschedule appointment success";
        break;
      case AuthResultStatus.complateAppointmentSuccess:
        errorMessage = "Complate appointment success";
        break;
      case AuthResultStatus.rateAppointmentSuccess:
        errorMessage = "Rate appointment success";
        break;
      case AuthResultStatus.initPaymentSuccess:
        errorMessage = "Init payment success";
        break;
      case AuthResultStatus.bookAppointmentFailed:
        errorMessage = "Book appointment failed";
        break;
      case AuthResultStatus.updateAppointmentFailed:
        errorMessage = "Update appointment failed";
        break;
      case AuthResultStatus.rescheduleAppointmentFailed:
        errorMessage = "Reschedule appointment failed";
        break;
      case AuthResultStatus.complateAppointmentFailed:
        errorMessage = "Complate appointment failed";
        break;
      case AuthResultStatus.rateAppointmentFailed:
        errorMessage = "Rate appointment failed";
        break;
      case AuthResultStatus.initPaymentFailed:
        errorMessage = "Init payment failed";
        break;
      case AuthResultStatus.confirmPaymentFailed:
        errorMessage = "Confirm payment failed";
        break;
      case AuthResultStatus.getTokenFailed:
        errorMessage = 'Get twilio token failed';
        break;
      case AuthResultStatus.createChannelFailed:
        errorMessage = "Create channel failed";
        break;
      case AuthResultStatus.firebaseUserNull:
        errorMessage = 'Firebase user null';
        break;
      case AuthResultStatus.kFailedToRecoverAuthError:
        errorMessage =
            'Error code indicating there was a failed attempt to recover user authentication';
        break;
      case AuthResultStatus.kUserRecoverableAuthError:
        errorMessage =
            'Error indicating that authentication can be recovered with user action';
        break;
      case AuthResultStatus.kSignInRequiredError:
        errorMessage =
            'Error code indicating there is no signed in user and interactive sign in flow is required';
        break;
      case AuthResultStatus.kSignInCanceledError:
        errorMessage =
            'Error code indicating that interactive sign in process was canceled by the user';
        break;
      case AuthResultStatus.kNetworkError:
        errorMessage =
            'Error code indicating network error. Retrying should resolve the problem';
        break;
      case AuthResultStatus.kSignInFailedError:
        errorMessage = 'Error code indicating that attempt to sign in failed';
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }

  static generateRequirementMessage(requirementCode) {
    String requirementMessage;

    switch (requirementCode) {
      case UserProfileStatus.completed:
        requirementMessage = '';
        break;
      case UserProfileStatus.dateOfBirth:
        requirementMessage = 'Please fill in your date of birth';
        break;
      case UserProfileStatus.idNumber:
        requirementMessage = 'Please fill in your id card number';
        break;
      case UserProfileStatus.mobileNumber:
        requirementMessage = 'Please fill in your mobile number';
        break;
      case UserProfileStatus.gender:
        requirementMessage = 'Please fill in your gender';
        break;
      case UserProfileStatus.country:
        requirementMessage = 'Please fill in your country';
        break;
      case UserProfileStatus.maritalStatus:
        requirementMessage = 'Please fill in your marital status';
        break;
      case UserProfileStatus.religion:
        requirementMessage = 'Please fill in your religion';
        break;
      case UserProfileStatus.ethnic:
        requirementMessage = 'Please fill in your ethnic';
        break;
      case UserProfileStatus.questionnaire:
        requirementMessage =
            'To serve you better, please complete your psychological enquiry as requested by our psychologists.';
        break;

      default:
        requirementMessage = 'Please fill your user profile';
    }

    return requirementMessage;
  }
}
