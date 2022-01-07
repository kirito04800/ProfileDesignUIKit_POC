//
//  AttributedString.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

struct AttributedString {
    let attributedString: NSAttributedString
}

extension AttributedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        attributedString = NSAttributedString(string: value)
    }
}

extension AttributedString: ExpressibleByStringInterpolation {
    public init(stringInterpolation: StringInterpolation) {
        attributedString = stringInterpolation.attributedString
    }

    struct StringInterpolation: StringInterpolationProtocol {
        let attributedString: NSMutableAttributedString

        init(literalCapacity: Int, interpolationCount: Int) {
            attributedString = NSMutableAttributedString()
        }

        func appendLiteral(_ literal: StringLiteralType) {
            attributedString.append(NSAttributedString(string: literal))
        }

        func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
            attributedString.append(NSAttributedString(string: string, attributes: attributes))
        }
    }
}

extension AttributedString.StringInterpolation {
    struct Attribute {
        let key: NSAttributedString.Key
        let value: Any
    }

    func appendInterpolation(_ string: String, attributes: [Attribute]) {
        let attrs = attributes.reduce(into: [:]) { $0[$1.key] = $1.value }
        appendInterpolation(string, attributes: attrs)
    }
}

extension AttributedString.StringInterpolation {
    func appendInterpolation(_ string: String, color: UIColor) {
        appendInterpolation(string, attributes: [.foregroundColor: color])
    }

    func appendInterpolation(_ string: String, font: UIFont) {
        appendInterpolation(string, attributes: [.font: font])
    }

    func appendInterpolation(_ string: String, link: URL) {
        appendInterpolation(string, attributes: [.link: link])
    }
}

extension AttributedString.StringInterpolation.Attribute {
    static func color(_ color: UIColor) -> Self {
        Self(key: .foregroundColor, value: color)
    }

    static func font(_ font: UIFont) -> Self {
        Self(key: .font, value: font)
    }

    static func link(_ link: URL) -> Self {
        Self(key: .link, value: link)
    }
}
