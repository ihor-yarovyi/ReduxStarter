// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum Alert {
    public enum Actions {
      /// OK
      public static let ok = Strings.tr("Localizable", "alert.actions.ok")
    }
    public enum Titles {
      /// Error
      public static let error = Strings.tr("Localizable", "alert.titles.error")
    }
  }

  public enum ImageCroppingView {
    public enum Actions {
      /// Cancel
      public static let cancel = Strings.tr("Localizable", "image_cropping_view.actions.cancel")
      /// Crop
      public static let crop = Strings.tr("Localizable", "image_cropping_view.actions.crop")
    }
  }

  public enum Validation {
    /// %@ has not valid format
    public static func hasNotValidFormat(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.hasNotValidFormat", String(describing: p1))
    }
    /// %@ must be from %d to %d symbols
    public static func mustBe(_ p1: Any, _ p2: Int, _ p3: Int) -> String {
      return Strings.tr("Localizable", "validation.mustBe", String(describing: p1), p2, p3)
    }
    /// %@ cannot contain spaces
    public static func noSpaces(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.noSpaces", String(describing: p1))
    }
    /// %@ don't match
    public static func notMatch(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.notMatch", String(describing: p1))
    }
    /// %@ is invalid
    public static func notValid(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.notValid", String(describing: p1))
    }
    /// %@ is required
    public static func `required`(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.required", String(describing: p1))
    }
    /// %@ should contain at least one letter and one digit and one capital letter
    public static func shouldContain(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.shouldContain", String(describing: p1))
    }
    /// %@ should not contain @ and spases
    public static func shouldNotContain(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.shouldNotContain", String(describing: p1))
    }
    /// %@ can't contain spaces only
    public static func spaceOnly(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.spaceOnly", String(describing: p1))
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
