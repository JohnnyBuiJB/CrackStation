import Foundation

public class CrackStation: Decrypter {
    private var lookupTable: [String: String] = [:]

    private static func loadDictionaryFromDisk() throws -> [String : String] {
        guard let path = Bundle.module.url(forResource: "HashDict", withExtension: "json") else { return [:] }

        let data = try Data(contentsOf: path)
        let jsonResult = try JSONSerialization.jsonObject(with: data)

        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
            return lookupTable
        } else {
            return [:]
        }
    }
    
    public required init() {
        do {
            lookupTable = try CrackStation.loadDictionaryFromDisk()
        }
        catch {
            print("Initialization fails!")
        }
    }

    public func decrypt(shaHash: String) -> String? {
        return lookupTable[shaHash]
    }
}
