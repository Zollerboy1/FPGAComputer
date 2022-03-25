extension DefaultStringInterpolation {
    public mutating func appendInterpolation<Value>(_ value: Value, radix: Int, paddedToWidth minimumWidth: Int) where Value: BinaryInteger {
        let isNegative = value < 0
        
        let valueString = String(value.magnitude, radix: radix)
        
        let paddingLength: Int
        let signString: String
        if isNegative {
            paddingLength = minimumWidth - valueString.count - 1
            signString = isNegative ? "-" : "+"
        } else {
            paddingLength = minimumWidth - valueString.count
            signString = ""
        }
        
        let paddingString: String
        if paddingLength > 0 {
            paddingString = String(repeating: "0", count: paddingLength)
        } else {
            paddingString = ""
        }
        
        self.appendLiteral(paddingString + signString + valueString)
    }
}


extension OptionSet {
    static func |(lhs: Self, rhs: Self) -> Self {
        lhs.union(rhs)
    }
}


struct ControlWord: OptionSet, ExpressibleByIntegerLiteral {
    let rawValue: Int
    
    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    init(integerLiteral value: Int) {
        self.rawValue = value
    }
    
    
    static let HLT: ControlWord = .init(rawValue: 1 << 0)
    static let AE:  ControlWord = .init(rawValue: 1 << 1)
    static let RI:  ControlWord = .init(rawValue: 1 << 2)
    static let RO:  ControlWord = .init(rawValue: 1 << 3)
    static let IE:  ControlWord = .init(rawValue: 1 << 4)
    static let OI:  ControlWord = .init(rawValue: 1 << 5)
    static let OO:  ControlWord = .init(rawValue: 1 << 6)
    static let MR:  ControlWord = .init(rawValue: 1 << 7)
    static let CI:  ControlWord = .init(rawValue: 1 << 8)
    static let CE:  ControlWord = .init(rawValue: 1 << 9)
    static let CO:  ControlWord = .init(rawValue: 1 << 10)
    static let AI:  ControlWord = .init(rawValue: 1 << 11)
    static let AO:  ControlWord = .init(rawValue: 1 << 12)
    static let S0:  ControlWord = .init(rawValue: 1 << 13)
    static let S1:  ControlWord = .init(rawValue: 1 << 14)
    static let S2:  ControlWord = .init(rawValue: 1 << 15)
    static let S3:  ControlWord = .init(rawValue: 1 << 16)
    static let SO:  ControlWord = .init(rawValue: 1 << 17)
    static let FE:  ControlWord = .init(rawValue: 1 << 18)
    static let BI:  ControlWord = .init(rawValue: 1 << 19)
    static let BO:  ControlWord = .init(rawValue: 1 << 20)
    static let DI:  ControlWord = .init(rawValue: 1 << 21)


    static let ADD: ControlWord = .FE
    static let SUB: ControlWord = .S0 | .FE
    static let INC: ControlWord = .S1 | .FE
    static let DEC: ControlWord = .S1 | .S0 | .FE
    static let AND: ControlWord = .S2 | .FE
    static let OR:  ControlWord = .S2 | .S0 | .FE
    static let XOR: ControlWord = .S2 | .S1 | .FE
    static let NOT: ControlWord = .S2 | .S1 | .S0 | .FE
    static let SHL: ControlWord = .S3 | .FE
    static let SHR: ControlWord = .S3 | .S0 | .FE
    static let ASL: ControlWord = .S3 | .S1 | .FE
    static let ASR: ControlWord = .S3 | .S1 | .S0 | .FE
    static let GT:  ControlWord = .S3 | .S2 | .FE
    static let EQ:  ControlWord = .S3 | .S2 | .S0 | .FE
    static let PTA: ControlWord = .S3 | .S2 | .S1 | .FE
    static let PTB: ControlWord = .S3 | .S2 | .S1 | .S0 | .FE
}


struct Instruction {
    let name: String
    let steps: [ControlWord]
    
    init(name: String, steps step0: ControlWord, _ step1: ControlWord, _ step2: ControlWord, _ step3: ControlWord, _ step4: ControlWord, _ step5: ControlWord, _ step6: ControlWord, _ step7: ControlWord) {
        self.name = name
        self.steps = [step0, step1, step2, step3, step4, step5, step6, step7]
    }


    
}


let instructionsTemplate: [Instruction] = [
    //                                0                  1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0000 1111
    //                                0                  1                 2                 3                 4                 5              6              7
    .init(name: "ADDA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .ADD,              .MR,                0,                0,             0,             0), // 0001 0000
    .init(name: "SUBA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .SUB,              .MR,                0,                0,             0,             0), // 0001 0001
    .init(name: "INCA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .INC,              .MR,                0,                0,             0,             0), // 0001 0010
    .init(name: "DECA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .DEC,              .MR,                0,                0,             0,             0), // 0001 0011
    .init(name: "ANDA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .AND,              .MR,                0,                0,             0,             0), // 0001 0100
    .init(name: "ORA",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .AI | .OR,              .MR,                0,                0,             0,             0), // 0001 0101
    .init(name: "XORA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .XOR,              .MR,                0,                0,             0,             0), // 0001 0110
    .init(name: "NOTA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .NOT,              .MR,                0,                0,             0,             0), // 0001 0111
    .init(name: "SHLA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .SHL,              .MR,                0,                0,             0,             0), // 0001 1000
    .init(name: "SHRA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .SHR,              .MR,                0,                0,             0,             0), // 0001 1001
    .init(name: "ASLA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .ASL,              .MR,                0,                0,             0,             0), // 0001 1010
    .init(name: "ASRA",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .AI | .ASR,              .MR,                0,                0,             0,             0), // 0001 1011
    .init(name: "GTA",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .AI | .GT,              .MR,                0,                0,             0,             0), // 0001 1100
    .init(name: "EQA",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .AI | .EQ,              .MR,                0,                0,             0,             0), // 0001 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0001 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0001 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "LDA",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI,              .MR,             0,             0), // 0010 0000
    .init(name: "LDB",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI,              .MR,             0,             0), // 0010 0001
    .init(name: "LDO",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .DI,              .MR,             0,             0), // 0010 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 0111
    .init(name: "STA",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .AO | .RI,              .MR,             0,             0), // 0010 1000
    .init(name: "STB",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .BO | .RI,              .MR,             0,             0), // 0010 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0010 1011
    .init(name: "CPAB",  steps: .CO | .AE, .RO | .IE | .CE,        .AO | .BI,              .MR,                0,                0,             0,             0), // 0010 1100
    .init(name: "CPBA",  steps: .CO | .AE, .RO | .IE | .CE,        .BO | .AI,              .MR,                0,                0,             0,             0), // 0010 1101
    .init(name: "CPAD",  steps: .CO | .AE, .RO | .IE | .CE,        .AO | .DI,              .MR,                0,                0,             0,             0), // 0010 1110
    .init(name: "CPBD",  steps: .CO | .AE, .RO | .IE | .CE,        .BO | .DI,              .MR,                0,                0,             0,             0), // 0010 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "LADDA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .ADD,           .MR,             0), // 0011 0000
    .init(name: "LSUBA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .SUB,           .MR,             0), // 0011 0001
    .init(name: "LINCA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .AI | .INC,           .MR,             0), // 0011 0010
    .init(name: "LDECA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .AI | .DEC,           .MR,             0), // 0011 0011
    .init(name: "LANDA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .AND,           .MR,             0), // 0011 0100
    .init(name: "LORA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI,  .SO | .AI | .OR,           .MR,             0), // 0011 0101
    .init(name: "LXORA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .XOR,           .MR,             0), // 0011 0110
    .init(name: "LNOTA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .AI | .NOT,           .MR,             0), // 0011 0111
    .init(name: "LSHLA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .SHL,           .MR,             0), // 0011 1000
    .init(name: "LSHRA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .SHR,           .MR,             0), // 0011 1001
    .init(name: "LASLA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .ASL,           .MR,             0), // 0011 1010
    .init(name: "LASRA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .AI | .ASR,           .MR,             0), // 0011 1011
    .init(name: "LGTA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI,  .SO | .AI | .GT,           .MR,             0), // 0011 1100
    .init(name: "LEQA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI,  .SO | .AI | .EQ,           .MR,             0), // 0011 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0011 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0011 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "OLDA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE,        .SO | .AE,        .RO | .AI,           .MR,             0), // 0100 0000
    .init(name: "OLDB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE,        .SO | .AE,        .RO | .BI,           .MR,             0), // 0100 0001
    .init(name: "OLDO",  steps: .CO | .AE, .RO | .IE | .CE,        .BO | .OI,        .CO | .AE,  .RO | .BI | .CE,        .SO | .AE,     .RO | .DI,     .OO | .BI), // 0100 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 0111
    .init(name: "OSTA",  steps: .CO | .AE, .RO | .IE | .CE,        .AO | .OI,        .CO | .AE,  .RO | .AI | .CE,        .SO | .AE,     .OO | .AI,     .AO | .RI), // 0100 1000
    .init(name: "OSTB",  steps: .CO | .AE, .RO | .IE | .CE,        .BO | .OI,        .CO | .AE,  .RO | .BI | .CE,        .SO | .AE,     .OO | .BI,     .BO | .RI), // 0100 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0100 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "CADDA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .ADD,              .MR,             0,             0), // 0101 0000
    .init(name: "CSUBA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .SUB,              .MR,             0,             0), // 0101 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0101 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0101 0011
    .init(name: "CANDA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .AND,              .MR,             0,             0), // 0101 0100
    .init(name: "CORA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE,  .SO | .AI | .OR,              .MR,             0,             0), // 0101 0101
    .init(name: "CXORA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .XOR,              .MR,             0,             0), // 0101 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0101 0111
    .init(name: "CSHLA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .SHL,              .MR,             0,             0), // 0101 1000
    .init(name: "CSHRA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .SHR,              .MR,             0,             0), // 0101 1001
    .init(name: "CASLA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .ASL,              .MR,             0,             0), // 0101 1010
    .init(name: "CASRA", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE, .SO | .AI | .ASR,              .MR,             0,             0), // 0101 1011
    .init(name: "CGTA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE,  .SO | .AI | .GT,              .MR,             0,             0), // 0101 1100
    .init(name: "CEQA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE,  .SO | .AI | .EQ,              .MR,             0,             0), // 0101 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0101 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0101 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "CLDA",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE,              .MR,                0,             0,             0), // 0110 0000
    .init(name: "CLDB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .BI | .CE,              .MR,                0,             0,             0), // 0110 0001
    .init(name: "CLDO",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .DI | .CE,              .MR,                0,             0,             0), // 0110 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 0111
    .init(name: "CST",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .OI | .CE,        .CO | .AE,  .RO | .AE | .CE,     .OO | .RI,           .MR), // 0110 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0110 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 0111 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1000 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "ADDB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .ADD,              .MR,                0,                0,             0,             0), // 1001 0000
    .init(name: "SUBB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .SUB,              .MR,                0,                0,             0,             0), // 1001 0001
    .init(name: "INCB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .INC,              .MR,                0,                0,             0,             0), // 1001 0010
    .init(name: "DECB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .DEC,              .MR,                0,                0,             0,             0), // 1001 0011
    .init(name: "ANDB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .AND,              .MR,                0,                0,             0,             0), // 1001 0100
    .init(name: "ORB",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .BI | .OR,              .MR,                0,                0,             0,             0), // 1001 0101
    .init(name: "XORB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .XOR,              .MR,                0,                0,             0,             0), // 1001 0110
    .init(name: "NOTB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .NOT,              .MR,                0,                0,             0,             0), // 1001 0111
    .init(name: "SHLB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .SHL,              .MR,                0,                0,             0,             0), // 1001 1000
    .init(name: "SHRB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .SHR,              .MR,                0,                0,             0,             0), // 1001 1001
    .init(name: "ASLB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .ASL,              .MR,                0,                0,             0,             0), // 1001 1010
    .init(name: "ASRB",  steps: .CO | .AE, .RO | .IE | .CE, .SO | .BI | .ASR,              .MR,                0,                0,             0,             0), // 1001 1011
    .init(name: "GTB",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .BI | .GT,              .MR,                0,                0,             0,             0), // 1001 1100
    .init(name: "EQB",   steps: .CO | .AE, .RO | .IE | .CE,  .SO | .BI | .EQ,              .MR,                0,                0,             0,             0), // 1001 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1001 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1001 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1010 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "LADDB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .ADD,           .MR,             0), // 1011 0000
    .init(name: "LSUBB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .SUB,           .MR,             0), // 1011 0001
    .init(name: "LINCB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .BI | .INC,           .MR,             0), // 1011 0010
    .init(name: "LDECB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .BI | .DEC,           .MR,             0), // 1011 0011
    .init(name: "LANDB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .AND,           .MR,             0), // 1011 0100
    .init(name: "LORB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI,  .SO | .BI | .OR,           .MR,             0), // 1011 0101
    .init(name: "LXORB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .XOR,           .MR,             0), // 1011 0110
    .init(name: "LNOTB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .BI, .SO | .BI | .NOT,           .MR,             0), // 1011 0111
    .init(name: "LSHLB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .SHL,           .MR,             0), // 1011 1000
    .init(name: "LSHRB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .SHR,           .MR,             0), // 1011 1001
    .init(name: "LASLB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .ASL,           .MR,             0), // 1011 1010
    .init(name: "LASRB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI, .SO | .BI | .ASR,           .MR,             0), // 1011 1011
    .init(name: "LGTB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI,  .SO | .BI | .GT,           .MR,             0), // 1011 1100
    .init(name: "LEQB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AE | .CE,        .RO | .AI,  .SO | .BI | .EQ,           .MR,             0), // 1011 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1011 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1011 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1100 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "CADDB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .ADD,              .MR,             0,             0), // 1101 0000
    .init(name: "CSUBB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .SUB,              .MR,             0,             0), // 1101 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1101 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1101 0011
    .init(name: "CANDB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .AND,              .MR,             0,             0), // 1101 0100
    .init(name: "CORB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE,  .SO | .BI | .OR,              .MR,             0,             0), // 1101 0101
    .init(name: "CXORB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .XOR,              .MR,             0,             0), // 1101 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1101 0111
    .init(name: "CSHLB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .SHL,              .MR,             0,             0), // 1101 1000
    .init(name: "CSHRB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .SHR,              .MR,             0,             0), // 1101 1001
    .init(name: "CASLB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .ASL,              .MR,             0,             0), // 1101 1010
    .init(name: "CASRB", steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE, .SO | .BI | .ASR,              .MR,             0,             0), // 1101 1011
    .init(name: "CGTB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE,  .SO | .BI | .GT,              .MR,             0,             0), // 1101 1100
    .init(name: "CEQB",  steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,  .RO | .AI | .CE,  .SO | .BI | .EQ,              .MR,             0,             0), // 1101 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1101 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1101 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 0111
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1001
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1010
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1110 1111
    //                                  0                1                 2                 3                 4                 5              6              7
    .init(name: "JMP",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,        .RO | .CI,              .MR,                0,             0,             0), // 1111 0000
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 0001
    .init(name: "JMPA",  steps: .CO | .AE, .RO | .IE | .CE,        .AO | .CI,              .MR,                0,                0,             0,             0), // 1111 0010
    .init(name: "JMPB",  steps: .CO | .AE, .RO | .IE | .CE,        .BO | .CI,              .MR,                0,                0,             0,             0), // 1111 0011
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 0100
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 0101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 0110
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 0111
    .init(name: "BC",    steps: .CO | .AE, .RO | .IE | .CE,              .CE,              .MR,                0,                0,             0,             0), // 1111 1000
    .init(name: "BNC",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,        .RO | .CI,              .MR,                0,             0,             0), // 1111 1001
    .init(name: "BZ",    steps: .CO | .AE, .RO | .IE | .CE,              .CE,              .MR,                0,                0,             0,             0), // 1111 1010
    .init(name: "BNZ",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,        .RO | .CI,              .MR,                0,             0,             0), // 1111 1011
    .init(name: "BO",    steps: .CO | .AE, .RO | .IE | .CE,              .CE,              .MR,                0,                0,             0,             0), // 1111 1100
    .init(name: "BNO",   steps: .CO | .AE, .RO | .IE | .CE,        .CO | .AE,        .RO | .CI,              .MR,                0,             0,             0), // 1111 1101
    .init(name: "NOP",   steps: .CO | .AE, .RO | .IE | .CE,              .MR,                0,                0,                0,             0,             0), // 1111 1110
    .init(name: "HLT",   steps: .CO | .AE, .RO | .IE | .CE,             .HLT,                0,                0,                0,             0,             0), // 1111 1111
]


var instructions: [Instruction] = []


for i in 0..<8 {
    var template = instructionsTemplate

    if (i & 0b001) != 0 {
        template[0b1111_1100] = .init(name: "BO",  steps: .CO | .AE, .RO | .IE | .CE, .CO | .AE, .RO | .CI, .MR, 0, 0, 0)
        template[0b1111_1101] = .init(name: "BNO", steps: .CO | .AE, .RO | .IE | .CE,       .CE,       .MR,   0, 0, 0, 0)
    }

    if (i & 0b010) != 0 {
        template[0b1111_1010] = .init(name: "BZ",  steps: .CO | .AE, .RO | .IE | .CE, .CO | .AE, .RO | .CI, .MR, 0, 0, 0)
        template[0b1111_1011] = .init(name: "BNZ", steps: .CO | .AE, .RO | .IE | .CE,       .CE,       .MR,   0, 0, 0, 0)
    }

    if (i & 0b100) != 0 {
        template[0b1111_1000] = .init(name: "BC",  steps: .CO | .AE, .RO | .IE | .CE, .CO | .AE, .RO | .CI, .MR, 0, 0, 0)
        template[0b1111_1001] = .init(name: "BNC", steps: .CO | .AE, .RO | .IE | .CE,       .CE,       .MR,   0, 0, 0, 0)
    }


    instructions.append(contentsOf: template)
}


for (i, instruction) in instructions.enumerated() {
    let flagsBits = (i & 0b111_0000_0000) >> 8
    let instructionMSB = (i & 0b000_1111_0000) >> 4
    let instructionLSB = (i & 0b000_0000_1111)

    print("")
    print("//                      H")
    print("// DBBFSSSSSAACCCMOOIRRAL")
    print("// IOIEO3210OIOEIROIEOIET")

    print("   \(instruction.steps.first!.rawValue, radix: 2, paddedToWidth: 22)   // 0 - \(flagsBits, radix: 2, paddedToWidth: 3) \(instructionMSB, radix: 2, paddedToWidth: 4) \(instructionLSB, radix: 2, paddedToWidth: 4) - \(instruction.name)")

    for (j, step) in instruction.steps.dropFirst().enumerated() {
        print("   \(step.rawValue, radix: 2, paddedToWidth: 22)   // \(j + 1)")
    }
}
