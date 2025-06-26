-- /src/SunTzu.json - Contains Sun Tzu quotes
{
    "quotes": [
        "\"He will win who knows when to fight and when not to fight.\" - Sun Tzu",
        "\"In the midst of chaos, there is also opportunity.\" - Sun Tzu",
        "\"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.\" - Sun Tzu",
        "\"Quickness is the essence of the war.\" - Sun Tzu",
        "\"Even the finest sword plunged into salt water will eventually rust.\" - Sun Tzu",
        "\"The art of war is of vital importance to the State. It is a matter of life and death, a road either to safety or to ruin. Hence it is a subject of inquiry which can on no account be neglected.\" - Sun Tzu",
        "\"There is no instance of a nation benefiting from prolonged warfare.\" - Sun Tzu",
        "\"There are not more than five musical notes, yet the combinations of these five give rise to more melodies than can ever be heard. There are not more than five primary colours, yet in combination they produce more hues than can ever been seen. There are not more than five cardinal tastes, yet combinations of them yield more flavours than can ever be tasted.\" - Sun Tzu",
        "\"Who wishes to fight must first count the cost.\" - Sun Tzu",
        "\"You have to believe in yourself.\" - Sun Tzu",
        "\"Build your opponent a golden bridge to retreat across.\" - Sun Tzu",
        "\"One may know how to conquer without being able to do it.\" - Sun Tzu",
        "\"What the ancients called a clever fighter is one who not only wins, but excels in winning with ease.\" - Sun Tzu",
        "\"The wise warrior avoids the battle.\" - Sun Tzu",
        "\"The whole secret lies in confusing the enemy, so that he cannot fathom our real intent.\" - Sun Tzu",
        "\"One mark of a great soldier is that he fight on his own terms or fights not at all.\" - Sun Tzu",
        "\"If the mind is willing, the flesh could go on and on without many things.\" - Sun Tzu",
        "\"He who is prudent and lies in wait for an enemy who is not, will be victorious.\" - Sun Tzu","Anger may in time change to gladness; vexation may be succeeded by content. But a kingdom that has once been destroyed can never come again into being; nor can the dead ever be brought back to life.\" - Sun Tzu",
        "\"There are roads which must not be followed, armies which must not be attacked, towns which must not be besieged, positions which must not be contested, commands of the sovereign which must not be obeyed.\" - Sun Tzu",
        "\"Attack is the secret of defense; defense is the planning of an attack.\" - Sun Tzu",
        "\"Great results can be achieved with small forces.\" - Sun Tzu",
        "\"Opportunities multiply as they are seized.\" - Sun Tzu",
        "\"If quick, I survive. If not quick, I am lost. This is death.\" - Sun Tzu",
        "\"To secure ourselves against defeat lies in our own hands, but the opportunity of defeating the enemy is provided by the enemy himself.\" - Sun Tzu",
        "\"Bravery without forethought, causes a man to fight blindly and desperately like a mad bull. Such an opponent, must not be encountered with brute force, but may be lured into an ambush and slain.\" - Sun Tzu",
        "\"Wheels of justice grind slow but grind fine.\" - Sun Tzu",
        "\"Never venture, never win!\" - Sun Tzu",
        "\"The skillful tactician may be likened to the shuai-jan. Now the shuai-jan is a snake that is found in the Chang mountains. Strike at its head, and you will be attacked by its tail; strike at its tail, and you will be attacked by its head; strike at its middle, and you will be attacked by head and tail both.\" - Sun Tzu",
        "\"It is easy to love your friend, but sometimes the hardest lesson to learn is to love your enemy.\" - Sun Tzu",
        "\"Be where your enemy is not.\" - Sun Tzu",
        "\"Who does not know the evils of war cannot appreciate its benefits.\" - Sun Tzu",
        "\"In battle, there are not more than two methods of attack-the direct and the indirect; yet these two in combination give rise to an endless series of maneuvers.\" - Sun Tzu",
        "\"Plan for what it is difficult while it is easy, do what is great while it is small.\" - Sun Tzu",
        "\"The opportunity of defeating the enemy is provided by the enemy himself.\" - Sun Tzu",
        "\"Foreknowledge cannot be gotten from ghosts and spirits, cannot be had by analogy, cannot be found out by calculation. It must be obtained from people, people who know the conditions of the enemy.\" - Sun Tzu",
        "\"If you fight with all your might, there is a chance of life; where as death is certain if you cling to your corner.\" - Sun Tzu",
        "\"Do not swallow bait offered by the enemy. Do not interfere with an army that is returning home.\" - Sun Tzu",
        "\"There are five dangerous faults which may affect a general: (1) Recklessness, which leads to destruction; (2) cowardice, which leads to capture; (3) a hasty temper, which can be provoked by insults; (4) a delicacy of honor which is sensitive to shame; (5) over-solicitude for his men, which exposes him to worry and trouble.\" - Sun Tzu",
        "\"Treat your men as you would your own beloved sons. And they will follow you into the deepest valley.\" - Sun Tzu"
    ]
}

-- /src/index.js - Main obfuscator entry point
//  src, yes this is rerubi based shit obf

let DefaultSettings = {
    '__VERSION__': '0.2.4',

    'Debug': false,
    'SkipMinify': false,
    'useRewriteGenerator': false,

    'BeautifyDebug': true,
    'PrintStep': false,
    'JIT': false,
    'Watermark': `herrtts obf, discord.gg/BZEjFbeUvk`,
    'Uid': '1',

    'AntiTamper': true,
    'MaximumSecurity': true,
    'UseSuperops': false
}

global.TopDir = __dirname
const fs = require('fs')
const path = require('path')
const child_process = require('child_process')
const BytecodeLib = require('./Bytecode')
const MacroLib = require('./Macros')
const ObfuscatorLib = require('./Obfuscator')
const GeneratorLib = require('./Generator')
const luamin = require('./minify.js')
const luamin2 = require('./luamin.js')
//let { stdout, stderr } = await exec(`cd "${path.join(__dirname, 'LUA')}" && lua.exe bytecodeDump.lua "${path.join(__dirname, 'temp', 'input.lua')}" "${path.join(__dirname, 'temp', 'output.hex')}"`)
async function dumpBytecode(source, input, output) {
    fs.writeFileSync(input, source)
    //console.log(`starting on ${process.platform}`)
    let file = process.platform === 'linux' ? 'lua5.1' : path.join(__dirname, 'lua', 'lua.exe')
    let settings = [ 
        path.join(__dirname, 'lua', 'bytecodeDump.lua'),
        input,
        output
    ]

    let linuxFix = `chmod +x "${file}"`
    let command = `${file} "${settings[0]}" "${settings[1]}" "${settings[2]}"`
    //if (process.platform === 'linux')
        //child_process.execSync(linuxFix)

    let ret = child_process.execSync(command)
    let { stderr, stdout } = ret
    if (stderr && stdout)
        console.log("ret(seo),", stderr.toString(), stdout.toString());
    else if(Buffer.isBuffer(ret))
        console.log("ret(b),", ret.toString());
    else
        console.log("ret,", ret);
    
    if (stderr !== '' && stderr !== null && stderr !== undefined)
        return { bytecode: '', error: stderr, stdout: stdout }
    return { bytecode: fs.readFileSync(output), error: null, out: ret.toString() }
}

//const opdata = require('./Bytecode/opdata.json')
module.exports = {
    obfuscate: async function(source, settings = DefaultSettings) {
        settings.TopDir = __dirname
        for (let i of Object.keys(DefaultSettings))
            settings[i] = settings[i] !== undefined ? settings[i] : DefaultSettings[i];
        
        // Dump bytecode from source
        if (settings.PrintStep)
            console.log('Dumping bytecode...')
        let inputFile = path.join(__dirname, 'temp', `input-${settings.Uid}.lua`)
        let outputFile = path.join(__dirname, 'temp', `output-${settings.Uid}.out`)
        let bytecodeData = null
        try {
            bytecodeData = await dumpBytecode(source, inputFile, outputFile)
        } catch(err) {
            try { fs.unlinkSync(inputFile) } catch(err) {}
            try { fs.unlinkSync(outputFile) } catch(err) {}
            throw err // idk why I do this, fuck off
        }

        try { fs.unlinkSync(inputFile) } catch(err) {}
        try { fs.unlinkSync(outputFile) } catch(err) {}


        if (bytecodeData.error !== null)
            throw `Errored, ${bytecodeData.error}`
        
        if (settings.PrintStep)
            console.log(bytecodeData.bytecode)
        if (settings.PrintStep)
            console.log('Decoding bytestring...')
        let byteString = bytecodeData.bytecode

        let chunkTree = await BytecodeLib.DecodeBytestring(byteString, settings)

        if (settings.PrintStep)
            console.log('Loading macros...')
        MacroLib.Visit(chunkTree, settings)
        if (settings.PrintStep)
            console.log('Modifying/Obfuscating chunk tree...')
        chunkTree = ObfuscatorLib.ModifyTree(chunkTree, settings)
        /*for (let i in chunkTree.Chunk.UsedInstructions) {
            console.log([ chunkTree.Opmap[i.toString()] ])
        }*/
    
        if (settings.PrintStep)
            console.log('Generating obfuscated code...')
        let code = await GeneratorLib.Generate(chunkTree, settings)
        if (settings.PrintStep) {
            console.log('Minifying code...')
        }

        if (settings.SkipMinify) {
            code = luamin2.Beautify(code, {
                RenameVariables: false,
                RenameGlobals: false,
                SolveMath: false
            })
        } else {
            if (settings.Debug === true) {
                if (settings.BeautifyDebug) {
                    code = luamin2.Beautify(code, {
                        RenameVariables: false,
                        RenameGlobals: false,
                        SolveMath: false
                    })
                }
            } else {
                // luamin.Minify
                code = luamin.Minify(code, {
                    RenameVariables: true,
                    RenameGlobals: false,
                    SolveMath: false
                })
            }
    
        }
        code = `--[[\n\therrtt's obfuscator, v${settings.__VERSION__}\n--]]\n\n` + code

        if (settings.JIT && process.platform === 'win32') {
            console.log(`Running file ('./obf/temp/output.lua')...`)
            fs.writeFileSync(`./obf/temp/output.lua`, code)
            try {
                await exec(`cd temp && lua output.lua`, { timeout: 2000 }, (err, stdout, stderr) => {
                    if (err) {
                        if (err.killed) {
                            console.log("Timeout!")
                        } else {
                            console.log("output:", stdout, stderr)
                        }
                    } else {
                        console.log(stdout)
                    }
                })
            } catch(err) { }
        }

        let outPath = path.join(__dirname, 'temp', `output-${settings.Uid}.lua`)
        fs.writeFileSync(outPath, code)

        return [ outPath, settings ]
    }
}

-- /src/run.js - CLI functionality
const fs = require('fs')


require('./index.js').obfuscate(
    fs.readFileSync('./temp/input.lua').toString()
).then(([ outputPath, settings ]) => {
    console.log(`saved to '${outputPath}'`)
    //fs.unlinkSync(outputPath)
}).catch((err) => {
    console.log("FAIOIIL", err)
})

-- /src/luamin.js - Lua beautification
/*
    Stravant thing in js
    Written by Herrtt (originally by Stravant)
*/

// I copied some comments
// no, it was not worth it
// please leave me alone
// I tried to copy+paste all comments, but no. I got bored.
// Be happy.

const print = console.log
const assert = function(a,b) {
    if (!a) {
        throw b
    }
}

function parseFloat(str, radix) { // Thanks stackoverflow (hex numbers with decimal)
    if (!str) return 0;
    var parts = str.toString().split(".");
    if (parts.length > 1) {
        return parseInt(parts[0], radix) + parseInt(parts[1], radix) / Math.pow(radix, parts[1].length);
    }
    return parseInt(parts[0], radix);
}

/** 
 * 
 * regex to make arr : (arr)\[(\S*)\]
 * replace value : $1.includes($2)
 * 
*/

let WhiteChars = [
    ' ', 
    '\n', 
    '\t', 
    '\r'
]


let Main_CharacterForEscape = {
    'r': '\r', 
    'n': '\n',
    't': '\t',
    '"': '"',
    "'": "'",
    '\\': '\\',
}

const CharacterForEscape = new Proxy(Main_CharacterForEscape, { 
    get(a, b) { return parseFloat(b) }
})

let AllIdentStartChars = [
    'A',    'B',    'C',    'D',
    'E',    'F',    'G',    'H',
    'I',    'J',    'K',    'L',
    'M',    'N',    'O',    'P',
    'Q',    'R',    'S',    'T',
    'U',    'V',    'W',    'X',
    'Y',    'Z',    '_',    'a',
    'b',    'c',    'd',    'e',
    'f',    'g',    'h',    'i',
    'j',    'k',    'l',    'm',
    'n',    'o',    'p',    'q',
    'r',    's',    't',    'u',
    'v',    'w',    'x',    'y',
    'z'
]

let AllIdentChars = [
    '0',    '1',    '2',    '3',
    '4',    '5',    '6',    '7',
    '8',    '9',    
    
    
    'A',    'B',
    'C',    'D',    'E',    'F',
    'G',    'H',    'I',    'J',
    'K',    'L',    'M',    'N',
    'O',    'P',    'Q',    'R',
    'S',    'T',    'U',    'V',
    'W',    'X',    'Y',    'Z',
    '_',    'a',    'b',    'c',
    'd',    'e',    'f',    'g',
    't',    'u',    'v',    'w',
    'h',    'i',    'j',    'k',
    'l',    'm',    'n',    'o',
    'p',    'q',    'r',    's',
    'x',    'y',    'z',     // this was actually fucking retarded to add, pls dont do this to me
]

let Digits = [
    '0','1','2','3',
    '4','5','6','7',
    '8','9',
]

let HexDigits = [
    //digits
    '0','1','2','3',
    '4','5','6','7',
    '8','9',

    //letters
    'a','b','c','d','e','f',
    'A','B','C','D','E','F',
]

let BinaryDigits = [
    '0', '1' // lol
]

let Symbols = [
    '+', '-', '*', ')', ';',  
    '/', '^', '%', '#',
    ',', '{', '}', ':',
    '[', ']', '(','.',
]

let EqualSymbols = [
    '~', '=', '>', '<'
]

let CompoundSymbols = [
    '+', '-', '*', '/', '^', '..', '%'
]

let Compounds = [
    '+=', '-=', '*=', '/=', '^=', '..=', '%='
]

let Keywords = [
    'and',      'break',    'do',   'else', 
    'elseif',   'end',      'false','for',
    'function', 'goto',     'if',   'in',
    'local',    'nil',      'not',  'or', 
    'repeat',   'return',   'then', 'true', 
    'until',    'while', 'continue'
]

let BlockFollowKeyword = [
    'else',     'elseif', 
    'until',    'end'
]

let UnopSet = [
    '-',    'not',  '#',
]

let BinopSet = [
    '+',    '-',     '*',   '/',    '%',    '^',    '#',    //algorithmic
    
    '..',   '.',     ':',   //dots / colons
    
    '>',    '<',     '<=',  '>=',   '~=',   '==',  //arrows / conditional
    
    '+=', '-=', '*=', '/=', '%=', '^=', '..=', // compounds

	'and',  'or'    // conditional 
]

/* let GlobalRenameIgnore = {
} //unused */
let BinaryPriority = {
    '+': [6, 6],
    '-': [6, 6],
    '*': [7, 7],
    '/': [7, 7],
    '%': [7, 7],
    '^': [10, 9],
    '..': [5, 4],
    '==': [3, 3],
    '~=': [3, 3],
    '>': [3, 3],
    '<': [3, 3],
    '>=': [3, 3],
    '<=': [3, 3],
    '+=': [3, 3],
    '-=': [3, 3],
    '*=': [3, 3],
    '/=': [3, 3],
    '^=': [3, 3],
    '%=': [3, 3],
    '..=': [3, 3],
    'and': [2, 2],
    'or': [1, 1],
}

let UnaryPriority = 8
// Eof, Ident, KeyWord, Number, String, Symbol

let uglyNames = []
let l = 0
let SHitA = ['x', 'X', 'y', 'Y', 'z', 'Z', '_']
let SHitB = ['b', 'B', 'u', 'U', 'o', 'O', '_']
function generateUglyName(l = 20) {
    function OwOIfy(str) {
        return str.split('').map(v=>{
            let c = Math.round(Math.random())
            if (c && v.toLowerCase() !== 'w') return v.toUpperCase();
            return v;
        }).join('')

    }
    let vars = SHitA // UGLY

    function gen() {
        let a = ""
        for (let i = 0; i<=l; i++) {
            let num = Math.floor(Math.random() * vars.length)
            a+= num !== 3? OwOIfy(vars[num]) : vars[num]
        }
        return a
    }

    let gamer = gen()
    while (uglyNames.includes(gamer))
        gamer = gen();

    uglyNames.push(gamer)

    return gamer
}


function CreateLuaTokenStream(text) {
    // Tracking for the current position in the buffer, and
    // the current line / character we are on

    let p = 0
    let length = text.length

    // Output buffer for tokens
    let tokenBuffer = []

    // Get a character or '' if at eof
    function look(n) {
        n = n || 0
        if (p <= length) {
            return text.substr(p + n, 1)
        } else {
            return ''
        }
    }

    function get() {
        if (p <= length) {
            let c = text.substr(p, 1)
            p++
            return c
        } else {
            return ''
        }
    }

    // Error
    function error(str) {
        let q = 0
        let line = 1
        let char = 1
        while (q <= p) {
            if (text.substr(q,1) == '\n') {
                line++
                char = 1
            } else {
                char++
            }
        }
        let i_;
        for (i_ = 0; i_ < tokenBuffer; i_++) {
            let token = tokenBuffer[i_]
            print(`${token.Type}<${token.Source}>`)
        }
        throw `file<${line}:${char}>: ${str}`
    }

    // Consume a long data with equals count of `eqcount`
    function longdata(eqcount) {
        while (true) {
            let c = get()
            if (c == '') {
                error("Unfinished long string.")
            } else if(c == ']') {
                let done = true // Until contested
                let i;
                for (i=1; i<=eqcount; i++) {
                    if (look() == '=') {
                        p++
                    } else {
                        done = false
                        break
                    }
                }
                if (done && get() == ']') {
                    return
                }
            }
        }
    }


    // Get the opening part for a long data `[` `=`` * `[`
    // Precondition: The first `[` has been consumed
    // Return: nil or the equals count

    function getopen() {
        let startp = p
        while (look() == '=') {
            p++
        }
        if (look() == '[') {
            p++
            return p - startp - 1
        } else {
            p = startp
            return
        }
    }


    // Add token
    let whiteStart = 0
    let tokenStart = 0
    let tokens = 0
    function token(type) {
        tokens++

        let src = text.substr(tokenStart, (p - tokenStart))
        let ntype = null
        if (type == "Number") {
            if (src.substr(0,2) == "0x") {
                ntype = 'hex'
                src = parseInt(src, 16)
            } else if(src.substr(0,2) == "0b") {
                ntype = 'bin'
                src = parseInt(src.substr(2), 2)
            }
        }
        let tk = {
            'Type': type,
            'LeadingWhite': text.substr(whiteStart, (tokenStart - whiteStart)),
            'Source': src
        }
        if (ntype !== null) {
            tk.NType = ntype
        }
        tokenBuffer.push(tk)

        whiteStart = p
        tokenStart = p
        return tk
    }

    // Parse tokens loop
    while (true) {
        // Mark the whitespace start
        whiteStart = p
        while (true) { // Whitespaces
            let c = look()
            if (c == '') {
                break
            } else if(c == '-') {

                if (look(1) == "-") {
                    p += 2

                    // Consume comment body
                    if (look() == "[") {

                        p++
                        let eqcount = getopen()
                        if (eqcount != null) {
                            // Long comment body
                            longdata(eqcount)
                            whiteStart = p
                        } else {
                            // Normal comment body
                            while (true) {
                                let c2 = get()
                                if (c2 == "" || c2 == "\n") {
                                    //whiteStart = p
                                    break
                                }
                            }
                        }
                    } else {
                        // Normal comment body
                        while (true) {
                            let c2 = get()
                            if (c2 == "" || c2 == "\n") {
                                //whiteStart = p
                                break
                            }
                        }
                    }
                } else {
                    break
                }
            } else if(WhiteChars.includes(c)) {
                p++
            } else {
                break
            }
        }

        // Mark the token start
        tokenStart = p

        // Switch on token type
        let c1 = get()
        if (c1 == '') {
            // End of file
            token('Eof')
            break
        } else if(c1 == '\'' || c1 == '\"') {
            // String constant
            
            while (true) {
                let c2 = get()
                if (c2 == '\\') {
                    let c3 = get()
                    if (Digits.includes(c3)) {
                        while (Digits.includes(look())) {
                            c3 += get()
                        }
                    }

                    let esc = CharacterForEscape[c3]

                    if (esc == null) {
                        throw (`Invalid Escape Sequence \`${c3}\`.`)
                    }
                } else if(c2 == c1) {
                    break
                } else if(c2 == "") {
                    throw ("Unfinished string!")
                }
            }
            token('String')
        } else if(AllIdentStartChars.includes(c1)) {
            // Ident or keyword
            while (AllIdentChars.includes(look())) {
                p++
            }

            if (Keywords.includes(text.substr(tokenStart, (p - tokenStart)))) {
                token("Keyword")
            } else {
                token("Ident")
            }
            
        } else if(Digits.includes(c1) || (c1 == '.' && Digits.includes(look()))) {
            // Number
            if (c1 == '0' && look() == 'x') {
                p++
                // Hex number
                while (HexDigits.includes(look())) {
                    p++
                }
            } else if (c1 == '0' && look() == 'b') {
                p++
                // Binary number
                while (BinaryDigits.includes(look())) {
                    p++
                }
            } else {
                // Normal number
                while (Digits.includes(look())) {
                    p++
                }

                if (look() == '.') {
                    // With decimal point
                    p++
                    while (Digits.includes(look())) {
                        p++
                    }
                }

                if (look() == 'e' || look() == 'E') {
                    // With exponent
                    p++
                    if (look() == '-') {
                        p++
                    }
                    while (Digits.includes(look())) {
                        p++
                    }
                }
            }
            token("Number")
        } else if(c1 == '[') {
            // Symbol or Long String
            let eqCount = getopen()
            if (eqCount != null) {
                // Long String
                longdata(eqCount)
                token("String")
            } else {
                // Symbol
                token("Symbol")
            }
        } else if(c1 == '.') {
            // Greedily consume up to 3 `.` for . / .. / ... tokens / ..= compound
            if (look() == '.') {
                get()
                if (look() == '.') {
                    get()
                } else if(look() == '=') {
                    get()
                }
            }
            token("Symbol")
        } else if(EqualSymbols.includes(c1)) {
            if (look() == "=") {
                p++
            }
            token("Symbol")
        } else if(CompoundSymbols.includes(c1) && look() == '=') {
            get()
            token('Symbol')
        } else if(Symbols.includes(c1)) {
            token("Symbol")
        } else {
            throw(`Bad symbol \`${c1}\` in source. ${p}`)
        }
    }

    return tokenBuffer
}

//Removelater


function CreateLuaParser(text) {
    // Token stream and pointer into it
    let tokens = CreateLuaTokenStream(text)

    let p = 0
    function get() {
        let tok = tokens[p]
        if (p < tokens.length) {
            p++
        }
        return tok
    }
    function peek(n) {
        n = p + (n || 0)
        return tokens[n] || tokens[tokens.length - 1]
    }

    function getTokenStartPosition(token) {
        let line = 1
        let char = 0
        let tkNum = 0
        while (true) {
            let tk = tokens[tkNum]
            let text
            if (tk == token) {
                text = tk.LeadingWhite
            } else {
                text = tk.LeadingWhite + tk.Source
            }

            let i
            for (i=0; i<=text.length; i++) {
                let c = text.substr(i, 1)
                if (c == '\n') {
                    line++
                    char = 0
                } else {
                    char++
                }
            }
            
            if (tk == token) {
                break
            }
            tkNum++
        }
        return `${line}:${char+1}`
    }

    function debugMark() {
        let tk = peek()
        return `<${tk.Type} \`${tk.Source}\`> at: ${getTokenStartPosition(tk)}`
    }

    function isBlockFollow() {
        let tok = peek()
        return tok.Type == 'Eof' || (tok.Type == 'Keyword' && BlockFollowKeyword.includes(tok.Source))   
    }

    function isUnop() {
        return UnopSet.includes(peek().Source) || false
    }

    function isBinop() {
        return BinopSet.includes(peek().Source) || false
    }

    function expect(type, source) {
        let tk = peek()
        if (tk.Type == type && (source == null || tk.Source == source)) {
            return get()
        } else {
            let i
            for (i=-3; i<=3; i++) {
                print(`Tokens[${i}] = \`${peek(i).Source}\``)
            }
            if (source) {
                let a = `${getTokenStartPosition(tk)}: \`${source}\` expected.`
                throw a
            } else {
                let a = `${getTokenStartPosition(tk)}: ${type} expected.`
                throw a
            }
        }
    }

    function MkNode(node) {
        let getf = node.GetFirstToken
        let getl = node.GetLastToken

        let self = node
        node.GetFirstToken = function() {
            let t = getf(self)
            assert(t)
            return t
        }

        node.GetLastToken = function() {
            let t = getl(self)
            assert(t)
            return t
        }

        return node
    }

    let block
    let expr

    function exprlist(locals, upvals) {
        let exprList = [expr(locals, upvals)]
        let commaList = []
        while (peek().Source == ",") {
            commaList.push(get())
            exprList.push(expr(locals, upvals))
        }
        return [exprList, commaList]
    }

    function prefixexpr(locals, upvals) {
        let tk = peek()
        if (tk.Source == '(') {
            let oparenTk = get()
            let inner = expr(locals, upvals)
            let cparenTk = expect('Symbol', ')')
            let node
            node = MkNode({
                'Type': 'ParenExpr',
                'Expression': inner,
                'Token_OpenParen': oparenTk,
                'Token_CloseParen': cparenTk,
                'GetFirstToken': () => node.Token_OpenParen,
                'GetLastToken': () => node.Token_CloseParen,
            })
            return node
        } else if(tk.Type == "Ident") {
            let node
            node = MkNode({
                'Type': 'VariableExpr',
                'Token': get(),
                'GetFirstToken': () => node.Token,
                'GetLastToken': () => node.Token,
            })

            if (locals[node.Token.Source] != null) {
                locals[node.Token.Source].Tokens.push(node.Token)
                locals[node.Token.Source].UseCountIncrease()
            } else if(upvals[node.Token.Source] != null) {
                upvals[node.Token.Source].Tokens.push(node.Token)
                upvals[node.Token.Source].UseCountIncrease()
            }

            return node
        } else {
            print(debugMark())
            let a = (`${getTokenStartPosition(tk)}: Unexpected symbol. ${tk.Type} ${tk.Source}`)
            throw a
        }
    }

    function tableexpr(locals, upvals) {
        let obrace = expect("Symbol", "{")
        let entries = []
        let seperators = []
        let length = 0

        let lastIndex

        let valLen = 0
        while (peek().Source != "}") {
            let indx
            let val
            if (peek().Source == '[') {
                // Index
                let obrac = get()
                let index = expr(locals, upvals)
                let cbrac = expect("Symbol", "]")
                let eq = expect("Symbol", "=")
                let value = expr(locals, upvals)

                indx = index.Token && index.Token.Source
                val = value

                entries.push({
                    "EntryType": "Index",
                    "Index": index,
                    "Value": value,
                    "Token_OpenBracket": obrac,
                    "Token_CloseBracket": cbrac,
                    "Token_Equals": eq,
                })
            } else if(peek().Type == "Ident" && peek(1).Source == "=") {
                // Field
                let field = get()
                let eq = get()
                let value = expr(locals, upvals)
                
                indx = field
                val = value
                entries.push({
                    "EntryType": "Field",
                    "Field": field,
                    "Value": value,
                    "Token_Equals": eq,
                })
            } else {
                // Value
        
                let value = expr(locals, upvals)
                entries.push({
                    "EntryType": "Value",
                    "Value": value,
                })
            }

            if (peek().Source == "," || peek().Source == ";") {
                seperators.push(get())
            } else {
                break
            }
        }

        let cbrace = expect("Symbol", "}")
        let node
        node = MkNode({
            "Type": "TableLiteral",
            "EntryList": entries,
            "Token_SeperatorList": seperators,
            "Token_OpenBrace": obrace,
            "Token_CloseBrace": cbrace,
            "GetFirstToken": () => node.Token_OpenBrace,
            "GetLastToken": () => node.Token_CloseBrace,
        })
        return node
    }


    function varlist(acceptVarg) {
        let varList = []
        let commaList = []
        if (peek().Type == "Ident") {
            varList.push(get())
        } else if(peek().Source == "..." && acceptVarg) {
            return [varList, commaList, get()]
        }
        while (peek().Source == ",") {
            commaList.push(get())
            if (peek().Source == "..." && acceptVarg) {
                return [varList, commaList, get()]
            } else {
                let id = expect("Ident")
                varList.push(id)
            }
        }
        return [varList, commaList]
    }

    function blockbody(terminator, locals, upvals) {
        let body = block(locals, upvals)
        let after = peek()
        if (after.Type == "Keyword" && after.Source == terminator) {
            get()
            return [body, after]
        } else {
            print(after.Type, after.Source)
            throw `${getTokenStartPosition(after)}: ${terminator} expected.`
        }
    }

    function funcdecl(isAnonymous, locals, upvals, local) {
        let functionKw = get()

        let nameChain
        let nameChainSeperator

        if (!isAnonymous) {
            nameChain = []
            nameChainSeperator = []

            let token = expect("Ident")
            nameChain.push(token)

            while (peek().Source == ".") { 
                nameChainSeperator.push(get())
                nameChain.push(expect("Ident"))
            }

            if (peek().Source == ":") {
                nameChainSeperator.push(get())
                nameChain.push(expect("Ident"))
            }
        }

        let oparenTk = expect("Symbol", "(")

        let [argList, argCommaList, vargToken] = varlist(true)
        let cparenTk = expect("Symbol", ")")
        let [fbody, enTk] = blockbody("end", locals, upvals)

        let node
        node = MkNode({
            "Type": (isAnonymous == true ? "FunctionLiteral" : "FunctionStat"),
            "NameChain": nameChain,
            "ArgList": argList,
            "Body": fbody,

            "Token_Function": functionKw,
            "Token_NameChainSeperator": nameChainSeperator,
            "Token_OpenParen": oparenTk,
            "Token_Varg": vargToken,
            "Token_ArgCommaList": argCommaList,
            "Token_CloseParen": cparenTk,
            "Token_End": enTk,
            "GetFirstToken": () => node.Token_Function,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function functionargs(locals, upvals) {
        let tk = peek()
        if (tk.Source == "(") {
            let oparenTk = get()
            let argList = []
            let argCommaList = []
            while (peek().Source != ")") {
                argList.push(expr(locals, upvals))
                if (peek().Source == ",") {
                    argCommaList.push(get())
                } else {
                    break
                }
            }

            let cparenTk = expect("Symbol", ")")
            let node
            node = MkNode({
                "CallType": "ArgCall",
                "ArgList": argList,

                "Token_CommaList": argCommaList,
                "Token_OpenParen": oparenTk,
                "Token_CloseParen": cparenTk,
                "GetFirstToken": () => node.Token_OpenParen,
                "GetLastToken": () => node.Token_CloseParen,
            })
            return node
        } else if(tk.Source == "{") {
            let node
            node = MkNode({
                "CallType": "TableCall",
                "TableExpr": expr(locals, upvals),
                "GetFirstToken": () => node.TableExpr.GetFirstToken(),
                "GetLastToken": () => node.TableExpr.GetLastToken(),
            })
            return node
        } else if(tk.Type == "String") {
            let node
            node = MkNode({
                "CallType": "StringCall",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else {
            throw "Function arguments expected."
        }
    }


    function primaryexpr(locals, upvals) {
        let base = prefixexpr(locals, upvals)
        assert(base, "nil prefixexpr")

        while (true) {
            let tk = peek()

            if (tk.Source == ".") {
                let dotTk = get()
                let fieldName = expect("Ident")
                let node
                node = MkNode({
                    "Type": "FieldExpr",
                    "Base": base,
                    "Field": fieldName,
                    "Token_Dot": dotTk,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Field,
                })
                base = node
            } else if(tk.Source == ":") {
                let colonTk = get()
                let methodName = expect("Ident")
                let fargs = functionargs(locals, upvals)
                let node
                node = MkNode({
                    "Type": "MethodExpr",
                    "Base": base,
                    "Method": methodName,
                    "FunctionArguments": fargs,
                    "Token_Colon": colonTk,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.FunctionArguments.GetLastToken(),
                })
                base = node
            } else if(tk.Source == "[") {
                let obrac = get()
                let index = expr(locals, upvals)
                let cbrac = expect("Symbol", "]")
                let node
                node = MkNode({
                    "Type": "IndexExpr",
                    "Base": base,
                    "Index": index,
                    "Token_OpenBracket": obrac,
                    "Token_CloseBracket": cbrac,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Token_CloseBracket,
                })
                base = node
            } else if(tk.Source == "{" || tk.Source == "(" || tk.Type == "String") {
                let node
                node = MkNode({
                    "Type": "CallExpr",
                    "Base": base,
                    "FunctionArguments": functionargs(locals, upvals),
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.FunctionArguments.GetLastToken(),
                })
                base = node
            } else if(Compounds.includes(tk.Source)) {
                let compoundTk = get()
                let rhsExpr = expr(locals, upvals)

                let node
                node = MkNode({
                    "Type": "CompoundStat",
                    "Base": base,
                    "Token_Compound": compoundTk,
                    "Rhs": rhsExpr,
                    "Lhs": base,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Rhs.GetLastToken(),
                })
                base = node
            } else {
                return base
            }
        }
    }

    function simpleexpr(locals, upvals) {
        let tk = peek()
        if (tk.Type == "Number") {
            let node
            node = MkNode({
                "Type": "NumberLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token
            })

            return node
        } else if(tk.Type == "String") {
            let node
            node = MkNode({
                "Type": "StringLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "nil") {
            let node
            node = MkNode({
                "Type": "NilLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "true" || tk.Source == "false") {
            let node
            node = MkNode({
                "Type": "BooleanLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "...") {
            let node
            node = MkNode({
                "Type": "VargLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "{") {
            return tableexpr(locals, upvals)
        } else if(tk.Source == "function") {
            return funcdecl(true, locals, upvals)
        } else {
            return primaryexpr(locals, upvals)
        }
    }

    function subexpr(limit, locals, upvals) {
        let curNode
        if (isUnop()) {
            let opTk = get()
            let ex = subexpr(UnaryPriority, locals, upvals)
            let node
            node = MkNode({
                "Type": "UnopExpr",
                "Token_Op": opTk,
                "Rhs": ex,
                "GetFirstToken": () => node.Token_Op,
                "GetLastToken": () => node.Rhs.GetLastToken(),
            })
            curNode = node
        } else {
            curNode = simpleexpr(locals, upvals)
            assert(curNode, "nil sipleexpr")
        }  
    
        while (isBinop() && BinaryPriority[peek().Source] != undefined && BinaryPriority[peek().Source][0] > limit) {
            let opTk = get()
            let rhs = subexpr(BinaryPriority[opTk.Source][1], locals, upvals)
            assert(rhs, "RhsNeeded")
            let node
            node = MkNode({
                "Type": "BinopExpr",
                "Lhs": curNode,
                "Rhs": rhs,
                "Token_Op": opTk,
                "GetFirstToken": () => node.Lhs.GetFirstToken(),
                "GetLastToken": () => node.Rhs.GetLastToken(),
            })
            curNode = node
        }
        return curNode
    }

    expr = (locals, upvals) => subexpr(0, locals, upvals)

    function exprstat(locals, upvals) {
        let ex = primaryexpr(locals, upvals)

        if (ex.Type == "MethodExpr" || ex.Type == "CallExpr") {
            let node
            node = MkNode({
                "Type": "CallExprStat",
                "Expression": ex,
                "GetFirstToken": () => node.Expression.GetFirstToken(),
                "GetLastToken": () => node.Expression.GetLastToken(),
            })
            return node
        } else if(ex.Type == "CompoundStat") {
            return ex
        } else {
            let lhs = [ex]
            let lhsSeperator = []
            while (peek().Source == ",") {
                lhsSeperator.push(get())
                let lhsPart = primaryexpr(locals, upvals)
                if (lhsPart.Type == "MethodExpr" || lhsPart.Type == "CallExpr") {
                    throw "Bad left hand side of asignment"
                }
                lhs.push(lhsPart)
            }
            let eq = expect("Symbol", "=")
            let rhs = [expr(locals, upvals)]
            let rhsSeperator = []
            while (peek().Source == ",") {
                rhsSeperator.push(get())
                rhs.push(expr(locals, upvals))
            }

            let node
            node = MkNode({
                "Type": "AssignmentStat",
                "Rhs": rhs,
                "Lhs": lhs,
                "Token_Equals": eq,
                "Token_LhsSeperatorList": lhsSeperator,
                "Token_RhsSeperatorList": rhsSeperator,
                "GetFirstToken": () => node.Lhs[0].GetFirstToken(),
                "GetLastToken": () => node.Rhs[node.Rhs.length - 1].GetLastToken(),
            })

            return node
        }
    }

    function ifstat(locals, upvals) {
        let ifKw = get()
        let condition = expr(locals, upvals)
        let thenKw = expect("Keyword", "then")
        let ifBody = block(locals, upvals)
        let elseClauses = []
        while (peek().Source == "elseif" || peek().Source == "else") {
            let elseifKw = get()
            let elseifCondition
            let elseifThenKw
            if (elseifKw.Source == "elseif") {
                elseifCondition = expr(locals, upvals)
                elseifThenKw = expect("Keyword", "then")
            }
            let elseifBody = block(locals, upvals)
            elseClauses.push({
                "Condition": elseifCondition,
                "Body": elseifBody,

                "ClauseType": elseifKw.Source,
                "Token": elseifKw,
                "Token_Then": elseifThenKw,
            })
            if (elseifKw.Source == "else") {
                break
            }
        }
        let enKw = expect("Keyword", "end")
        let node
        node = MkNode({
            "Type": "IfStat",
            "Condition": condition,
            "Body": ifBody,
            "ElseClauseList": elseClauses,
            
            "Token_If": ifKw,
            "Token_Then": thenKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_If,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }


    function dostat(locals, upvals) {
        let doKw = get()
        let [body, enKw] = blockbody("end", locals, upvals)
        
        let node
        node = MkNode({
            "Type": "DoStat",
            "Body": body,
            
            "Token_Do": doKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_Do,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function whilestat(locals, upvals) {
        let whileKw = get()
        let condition = expr(locals, upvals)
        let doKw = expect("Keyword", "do")
        let [body, enKw] = blockbody("end", locals, upvals)

        let node
        node = MkNode({
            "Type": "WhileStat",
            "Condition": condition,
            "Body": body,
            
            "Token_While": whileKw,
            "Token_Do": doKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_While,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function forstat(locals, upvals) {
        let forKw = get()
        let [loopVars, loopVarCommas] = varlist()
        let node = []
        if (peek().Source == "=") {
            let eqTk = get()
            let [exprList, exprCommaList] = exprlist(locals, upvals)
            if (exprList.length < 2 || exprList.length > 3) {
                throw "Expected 2 or 3 values for range bounds"
            }
            let doTk = expect("Keyword", "do")
            let [body, enTk] = blockbody("end", locals, upvals)
            let node
            node = MkNode({
                "Type": "NumericForStat",
                "VarList": loopVars,
                "RangeList": exprList,
                "Body": body,
                
                "Token_For": forKw,
                "Token_VarCommaList": loopVarCommas,
                "Token_Equals": eqTk,
                "Token_RangeCommaList": exprCommaList,
                "Token_Do": doTk,
                "Token_End": enTk,
                "GetFirstToken": () => node.Token_For,
                "GetLastToken": () => node.Token_End,
            })
            return node
        } else if(peek().Source == "in") {
            let inTk = get()
            let [exprList, exprCommaList] = exprlist(locals, upvals)
            let doTk = expect("Keyword", "do")
            let [body, enTk] = blockbody("end", locals, upvals)
            let node
            node = MkNode({
                "Type": "GenericForStat",
                "VarList": loopVars,
                "GeneratorList": exprList,
                "Body": body,

                "Token_For": forKw,
                "Token_VarCommaList": loopVarCommas,
                "Token_In": inTk,
                "Token_GeneratorCommaList": exprCommaList,
                "Token_Do": doTk,
                "Token_End": enTk,
                "GetFirstToken": () => node.Token_For,
                "GetLastToken": () => node.Token_End
            })
            return node
        }
    }

    function repeatstat(locals, upvals) {
        let repeatKw = get()
        let [body, untilTk] = blockbody("until", locals)
        let condition = expr(locals, upvals)

        let node
        node = MkNode({
            "Type": "RepeatStat",
            "Body": body,
            "Condition": condition,

            "Token_Repeat": repeatKw,
            "Token_Until": untilTk,
            "GetFirstToken": () => node.Token_Repeat,
            "GetLastToken": () => node.Condition.GetLastToken(),
        })
        return node
    }

    function localdecl(locals, upvals) {
        let localKw = get()
        if (peek().Source == "function") {
            let funcStat = funcdecl(false, locals, upvals, true)
            if (funcStat.NameChain.length > 1) {
                throw getTokenStartPosition(funcStat.Token_NameChainSeperator[0]) + ": `(` expected."
            }

            let node
            node = MkNode({
                "Type": "LocalFunctionStat",
                "FunctionStat": funcStat,
                "Token_Local": localKw,
                "GetFirstToken": () => node.Token_Local,
                "GetLastToken": () => node.FunctionStat.GetLastToken(),
            })
            return node
        } else if(peek().Type == "Ident") {
            let [varList, varCommaList] = varlist(false)
            let exprList = []
            let exprCommaList = []
            let eqToken
            if (peek().Source == "=") {
                eqToken = get()
                let [exprList1, exprCommaList1] = exprlist(locals, upvals)
                exprList = exprList1
                exprCommaList = exprCommaList1
            }
            

            let node
            node = MkNode({
                "Type": "LocalVarStat",
                "VarList": varList,
                "ExprList": exprList,
                "Token_Local": localKw,
                "Token_Equals": eqToken,
                "Token_VarCommaList": varCommaList,
                "Token_ExprCommaList": exprCommaList,
                "GetFirstToken": () => node.Token_Local,
                "GetLastToken": function() {
                    if (node.ExprList.length > 0) {
                        return node.ExprList[node.ExprList.length - 1].GetLastToken()
                    } else {
                        return node.VarList[node.VarList.length - 1]
                    }
                },
            })
            return node
        } else {
            throw "`function` or ident expected"
        }
    }

    function retstat(locals, upvals) {
        let returnKw = get()
        let exprList
        let commaList
        if (isBlockFollow() || peek().Source == ";") {
            exprList = []
            commaList = []
        } else {
            [exprList, commaList] = exprlist(locals, upvals)
        }
        let self
        self = {
            "Type": "ReturnStat",
            "ExprList": exprList,
            "Token_Return": returnKw,
            "Token_CommaList": commaList,
            "GetFirstToken": () => self.Token_Return,
            "GetLastToken": function() {
                if (self.ExprList.length > 0) {
                    return self.ExprList[self.ExprList.length- 1].GetLastToken()
                } else {
                    return self.Token_Return
                }
            },
        }
        return self
    }

    function breakstat(locals, upvals) {
        let breakKw = get()
        let self
        self = {
            "Type": "BreakStat",
            "Token_Break": breakKw,
            "GetFirstToken": () => self.Token_Break,
            "GetLastToken": () => self.Token_Break,
        }
        return self
    }

    function continuestat(locals, upvals) {
        let continueKw = get()
        let self
        self = {
            "Type": "ContinueStat",
            "Token_Continue": continueKw,
            "GetFirstToken": () => self.Token_Continue,
            "GetLastToken": () => self.Token_Continue,
        }
        return self
    }

    function statement(locals, upvals) {
        let tok = peek()
        if (tok.Source == "if") {
            return [false, ifstat(locals, upvals)]
        } else if(tok.Source == "while") {
            return [false, whilestat(locals, upvals)]
        } else if(tok.Source == "do") {
            return [false, dostat(locals, upvals)]
        } else if(tok.Source == "for") {
            return [false, forstat(locals, upvals)]
        } else if(tok.Source == "repeat") {
            return [false, repeatstat(locals, upvals)]
        } else if(tok.Source == "function") {
            return [false, funcdecl(false, locals, upvals)]
        } else if(tok.Source == "local") {
            return [false, localdecl(locals, upvals)]
        } else if(tok.Source == "return") {
            return [true, retstat(locals, upvals)]
        } else if(tok.Source == "break") {
            return [true, breakstat(locals, upvals)]
        } else if(tok.Source == "continue") {
            return [true, continuestat(locals, upvals)]
        } else {
            return [false, exprstat(locals, upvals)]
        }
    }


    let blocks = 1
    block = function(a, b) {
        let myblocknum = blocks++
        let statements = []
        let semicolons = []
        let isLast = false

        let locals = {}
        let upvals = {}
        if (b != null) {
            for (let [i, v] of Object.entries(b)) {
                upvals[i] = v
            }
        }

        if (a != null) {
            for (let [i, v] of Object.entries(a)) {
                upvals[i] = v
            }
        }


        let thing
        let i = 0
        while (!isLast && !isBlockFollow()) {
            if (thing && thing == peek()) {
                print(`INFINITE LOOP POSSIBLE ON STATEMENT ${thing.Source} :`,thing)
            }
            thing = peek()
            let [isLast, stat] = statement(locals, upvals)
            if (stat) {
                statements.push(stat);


                switch (stat.Type) {
                    case "LocalVarStat":
                        stat.VarList.forEach(token => {

                            token.UseCount = 0
                            token.Number = i++
                            locals[token.Source] = token

                            let tokens = []
                            function lol() {
                                token.UseCount++
                                tokens.forEach(t => {
                                    t.UseCount = token.UseCount
                                })
                            }

                            token.Tokens = {}
                            token.Tokens.push = (t) => {
                                t.UseCountIncrease = lol
                                t.UseCount = token.UseCount
                                t.Tokens = token.Tokens
                                tokens.push(t)
                            }
                            token.Tokens.get = () => tokens

                            token.UseCountIncrease = lol
                        })
                        break

                    case "LocalFunctionStat":

                        let nameChain = stat.FunctionStat.NameChain
                        if (nameChain.length === 1) {
                            let token = nameChain[0]
                            token.UseCount = 0
                            token.Number = i++
                            locals[token.Source] = token

                            let tokens = []
                            function lol() {
                                token.UseCount++
                                tokens.forEach(t => {
                                    t.UseCount = token.UseCount
                                })
                            }

                            token.Tokens = {}
                            token.Tokens.push = (t) => {
                                t.UseCountIncrease = lol
                                t.UseCount = token.UseCount
                                t.Tokens = token.Tokens
                                tokens.push(t)
                            }
                            token.Tokens.get = () => tokens

                            token.UseCountIncrease = lol
                        }
                        break

                    default:
                        break
                }
            }

            let next = peek()
            if (next.Type == "Symbol" && next.Source == ";") {
                semicolons[statements.length - 1] = get()
            }
        }

        let node
        node = {
            "Type": "StatList",
            "StatementList": statements,
            "SemicolonList": semicolons,
            "GetFirstToken": function() {
                if (node.StatementList.length == 0) {
                    return
                } else {
                    return node.StatementList[0].GetFirstToken()
                }
            },
            "GetLastToken": function() {
                if (node.StatementList.length == 0) {
                    return
                } else if(node.SemicolonList[node.StatementList.length - 1]) {
                    return node.SemicolonList[node.StatementList.length - 1]
                } else {
                    return node.StatementList[node.StatementList.length - 1].GetLastToken()
                }
            },
        }
        return node
    }

    return block()
}

function VisitAst(ast, visitors) {
    let ExprType = {
		'BinopExpr': true, 'UnopExpr': true, 
		'NumberLiteral': true, 'StringLiteral': true, 'NilLiteral': true, 'BooleanLiteral': true, 'VargLiteral': true,
		'FieldExpr': true, 'IndexExpr': true,
		'MethodExpr': true, 'CallExpr': true,
		'FunctionLiteral': true,
		'VariableExpr': true,
		'ParenExpr': true,
		'TableLiteral': true,
    }

    let StatType = {
		'StatList': true,
		'BreakStat': true,
        'ContinueStat': true,
		'ReturnStat': true,
		'LocalVarStat': true,
		'LocalFunctionStat': true,
		'FunctionStat': true,
		'RepeatStat': true,
		'GenericForStat': true,
		'NumericForStat': true,
		'WhileStat': true,
		'DoStat': true,
		'IfStat': true,
		'CallExprStat': true,
		'AssignmentStat': true,
        'CompoundStat': true
    }

    for (var [visitorSubject, visitor] of Object.entries(visitors)) {
        if (!StatType[visitorSubject] && !ExprType[visitorSubject]) {
            throw `Invalid visitor target: \`${visitorSubject}\``
        }
    }


    function preVisit(exprOrStat) {
        if (exprOrStat != null) {
            let visitor = visitors[exprOrStat.Type]
            if (typeof(visitor) == "function") {
                return visitor(exprOrStat)
            } else if(visitor && visitor.Pre) {
                return visitor.Pre(exprOrStat)
            }
        }
    }

    function postVisit(exprOrStat) {
        let visitor = visitors[exprOrStat.Type]
        if (visitor && typeof(visitor) == "object" && visitor.Post) {
            return visitor.Post(exprOrStat)
        }
    }

    let visitExpr
    let visitStat

    visitExpr = function(expr) {
        if (preVisit(expr)) {
            return
        }

        if (expr.Type == "BinopExpr") {
            visitExpr(expr.Lhs)
            visitExpr(expr.Rhs)
        } else if(expr.Type == "UnopExpr") {
            visitExpr(expr.Rhs)
        } else if(expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral") 
        {
            //No
        } else if(expr.Type == "FieldExpr") {
            visitExpr(expr.Base)
        } else if(expr.Type == "IndexExpr") {
            visitExpr(expr.Base)
            visitExpr(expr.Index)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            visitExpr(expr.Base)
            if (expr.FunctionArguments.CallType == "ArgCall") {
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    visitExpr(argExpr)
                })
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                visitExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            visitStat(expr.Body)
        } else if(expr.Type == "VariableExpr") {
            // no
        } else if(expr.Type == "ParenExpr") {
            visitExpr(expr.Expression)

        } else if(expr.Type == "TableLiteral") {
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    visitExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    visitExpr(entry.Index)
                    visitExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    visitExpr(entry.Value)
                } else {
                    throw "unreachable"
                }
            })
        } else if(expr.Type == "CompoundStat") {
            visitExpr(expr.Lhs)
            visitExpr(expr.Rhs)
        } else {
            throw `unreachable, type: ${expr.Type}: ${expr}`
        }
        postVisit(expr)
    }

    visitStat = function(stat) {
        if (preVisit(stat)) {
            return
        }

        if (stat.Type == "StatList") {
            stat.StatementList.forEach((ch, index) => {
                if (ch != null) {
                    if (ch === null || ch.Type === null) {
                        return
                    }
    
                    ch.Remove = () => {
                        stat.StatementList[index] = null
                    }

                    visitStat(ch)
                }
            })
        } else if(stat.Type == "BreakStat") {
            // no
        } else if(stat.Type == "ContinueStat") {
            // fuck off
        } else if(stat.Type == "ReturnStat") {
            stat.ExprList.forEach((expr, index) => {
                visitExpr(expr)
            })
        } else if(stat.Type == "LocalVarStat") {
            if (stat.Token_Equals) {
                stat.ExprList.forEach((expr, index) => {
                    visitExpr(expr)
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            visitStat(stat.FunctionStat.Body)
        } else if(stat.Type == "FunctionStat") {
            visitStat(stat.Body)
        } else if(stat.Type == "RepeatStat") {
            visitStat(stat.Body)
            visitExpr(stat.Condition)
        } else if(stat.Type == "GenericForStat") {
            stat.GeneratorList.forEach((expr, index) => {
                visitExpr(expr)
            })
            visitStat(stat.Body)
        } else if(stat.Type == "NumericForStat") {
            stat.RangeList.forEach((expr, index) => {
                visitExpr(expr)
            })
            visitStat(stat.Body)
        } else if(stat.Type == "WhileStat") {
            visitExpr(stat.Condition)
            visitStat(stat.Body)
        } else if(stat.Type == "DoStat") {
            visitStat(stat.Body)
        } else if(stat.Type == "IfStat") {
            visitExpr(stat.Condition)
            visitStat(stat.Body)
            stat.ElseClauseList.forEach((clause) => {
                if (clause.Condition != null) {
                    visitExpr(clause.Condition)
                }
                visitStat(clause.Body)
            })
        } else if(stat.Type == "CallExprStat") {
            visitExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") {
            visitExpr(stat.Rhs)
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex) => {
                visitExpr(ex)
            })
            stat.Rhs.forEach((ex) => {
                visitExpr(ex)
            })
        } else {
            throw "unreachable"
        }
        postVisit(stat)
    }
    
    if (StatType[ast.Type]) {
        visitStat(ast)
    } else {
        visitExpr(ast)
    }
}

function AddVariableInfo(ast) {
    let globalVars = []
    let currentScope

    let locationGenerator = 0
    function markLocation() {
        locationGenerator++
        return locationGenerator
    }

    function pushScope() {
        currentScope = {
            "ParentScope": currentScope,
            "ChildScopeList": [],
            "VariableList": [],
            "BeginLocation": markLocation(),
        }
        if (currentScope.ParentScope) {
            currentScope.Depth = currentScope.ParentScope.Depth + 1
            currentScope.ParentScope.ChildScopeList.push(currentScope)
        } else {
            currentScope.Depth = 1
        }
        let self = currentScope
        currentScope.GetVar = function(varName){
            self.VariableList.forEach((_var) => {
                if (_var.Name == varName) {
                    return _var
                }
            })
            if (self.ParentScope) {
                return self.ParentScope.GetVar(varName)
            } else {
                globalVars.forEach((_var) => {
                    if (_var.Name == varName) {
                        return _var
                    }
                })
            }
        }
    }

    function popScope() {
        let scope = currentScope

        scope.EndLocation = markLocation()

        scope.VariableList.forEach((v) => {
            v.ScopeEndLocation = scope.EndLocation
        })

        currentScope = scope.ParentScope
        return scope
    }
    pushScope()

    function addLocalVar(name, setNameFunc, localInfo) {
        assert(localInfo, "MIssing localInfo")
        assert(name, "Missing local var name")
        let _var = {
            "Type": "Local",
            "Name": name,
            "RenameList": [setNameFunc],
            "AssignedTo": false,
            "Info": localInfo,
            "Scope": currentScope,
            "BeginLocation": markLocation(),
            "EndLocation": markLocation(),
            "ReferenceLocationList": [markLocation()],
        }
        _var.Rename = function(newName) {
            _var.Name = newName
            _var.RenameList.forEach((renameFunc) => {
                renameFunc(newName)
            })
        }

        currentScope.VariableList.push(_var)
        return _var
    }

    function getGlobalVar(name) {
        globalVars.forEach((_var) => {
            if (_var.Name == name) {
                return _var
            }
        })

        let _var = {
            "Type": "Global",
            "Name": name,
            "RenameList": [],
            "AssignedTo": false,
            "Scope": null,
            "BeginLocation": markLocation(),
            "EndLocation": markLocation(),
            "ReferenceLocationList": [],
        }

        _var.Rename = function(newName) {
            _var.Name = newName
            _var.RenameList.forEach((renameFunc) => {
                renameFunc(newName)
            })
        }
        
        globalVars.push(_var)

        return _var
    }


    function addGlobalReference(name, setNameFunc) {
        assert(name, "Missing var name")
        let _var = getGlobalVar(name)
        _var.RenameList.push(setNameFunc)
        return _var
    }

    function getLocalVar(scope, name) {
        let i
        for (i=scope.VariableList.length-1; i>=0; i--) {
            if (scope.VariableList[i].Name == name) {
                return scope.VariableList[i]
            }
        }

        if (scope.ParentScope) {
            let _var = getLocalVar(scope.ParentScope, name)
            if (_var) {
                return _var
            }
        }

        return
    }

    function referenceVariable(name, setNameFunc) {
        assert(name, "Missing var name")
        let _var = getLocalVar(currentScope, name)
        if (_var) {
            _var.RenameList.push(setNameFunc)
        } else {
            _var = addGlobalReference(name, setNameFunc)
        }

        let curLocation = markLocation()
        _var.EndLocation = curLocation
        _var.ReferenceLocationList.push(_var.EndLocation)
        return _var
    }

    let visitor = {}
    visitor.FunctionLiteral = {

        "Pre": function(expr) {
            pushScope()
            expr.ArgList.forEach((ident, index) => {
                let _var = addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function(expr) {
            popScope()
        },
    }

    visitor.VariableExpr = function(expr) {
        expr.Variable = referenceVariable(expr.Token.Source, function(newName) {
            expr.Token.Source = newName
        })
    }

    visitor.StatList = {
        "Pre": function(stat) {
            pushScope()
        },

        "Post": function(stat) {
            if (!stat.SkipPop) {
                popScope()
            }
        },
    }

    visitor.LocalVarStat = {
        "Post": function(stat) {
    
            stat.VarList.forEach((ident, varNum) => {
                addLocalVar(ident.Source, function(name) {
                    stat.VarList[varNum].Source = name
                }, {
                    "Type": "Local",
                })
            })
        },
    }

    visitor.LocalFunctionStat = {
        "Pre": function(stat) {
            addLocalVar(stat.FunctionStat.NameChain[0].Source, function(name) {
                stat.FunctionStat.NameChain[0].Source = name
            }, {
                "Type": "LocalFunction",
            })

            pushScope()

            stat.FunctionStat.ArgList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function() {
            popScope()
        }
    }

    visitor.FunctionStat = {
        "Pre": function(stat) {
            let nameChain = stat.NameChain
            let _var
            if (nameChain.length == 1) {
                if (getLocalVar(currentScope, nameChain[0].Source)) {
                    _var = referenceVariable(nameChain[0].Source, function(name) {
                        nameChain[0].Source = name
                    })
                } else {
                    _var = addGlobalReference(nameChain[0].Source, function(name) {
                        nameChain[0].Source = name
                    })
                }
            } else {
                _var = referenceVariable(nameChain[0].Source, function(name) {
                    nameChain[0].Source = name
                })
            }
            _var.AssignedTo = true
            pushScope()
            stat.ArgList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function() {
            popScope()
        }
    }

    visitor.GenericForStat = {
        "Pre": function(stat) {

            stat.GeneratorList.forEach((ex) => {
                VisitAst(ex, visitor)
            })

            pushScope()
            stat.VarList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "ForRange",
                    "Index": index,
                })
            })
            VisitAst(stat.Body, visitor)
            popScope()
            return true
        }
    }

    visitor.NumericForStat = {
        "Pre": function(stat) {
            stat.RangeList.forEach((ex) => {
                VisitAst(ex, visitor)
            })

            pushScope()
            stat.VarList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "ForRange",
                    "Index": index,
                })
            })
            VisitAst(stat.Body, visitor)
            popScope()
            return true
        }
    }

    visitor.RepeatStat = {
        "Pre": function(stat) {
            stat.Body.SkipPop = true
        },
        "Post": function(stat) {
            popScope()
        }
    }
    visitor.AssignmentStat = {
        "Post": function(stat) {
            stat.Lhs.forEach((ex) => {
                if (ex.Variable != null) {
                    ex.Variable.AssignedTo = true
                }
            })
        }
    }
    VisitAst(ast, visitor)
    return [globalVars, popScope()]
}

function PrintAst(ast) {
    let printStat
    let printExpr
    let buffer = ''
    function printt(tk) {
        if (tk.LeadingWhite == null || tk.Source == null) {
            throw `Bad token: tk=${tk} | lwhite=${tk.LeadingWhite} | source=${tk.Source}`
        }
        buffer = `${buffer}${tk.LeadingWhite}${tk.Source}`
    }

    printExpr = function(expr) {
        if (expr.Type == "BinopExpr") {
            printExpr(expr.Lhs)
            printt(expr.Token_Op)
            printExpr(expr.Rhs)
        } else if(expr.Type == "UnopExpr") {
            printt(expr.Token_Op)
            printExpr(expr.Rhs)
        } else if(
                expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral") 
        {
            printt(expr.Token)
        } else if(expr.Type == "FieldExpr") {
            printExpr(expr.Base)
            printt(expr.Token_Dot)
            printt(expr.Field)
        } else if(expr.Type == "IndexExpr") {
            printExpr(expr.Base)
            printt(expr.Token_OpenBracket)
            printExpr(expr.Index)
            printt(expr.Token_CloseBracket)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            printExpr(expr.Base)
            if (expr.Type == "MethodExpr") {
                printt(expr.Token_Colon)
                printt(expr.Method)
            }
            if (expr.FunctionArguments.CallType == "StringCall") {
                printt(expr.FunctionArguments.Token)
            } else if(expr.FunctionArguments.CallType == "ArgCall") {
                printt(expr.FunctionArguments.Token_OpenParen)
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    printExpr(argExpr)
                    let sep = expr.FunctionArguments.Token_CommaList[index]
                     if (sep != null) {
                        printt(sep)
                    }
                })
                printt(expr.FunctionArguments.Token_CloseParen)
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                printExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            printt(expr.Token_Function)
            printt(expr.Token_OpenParen)
            expr.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = expr.Token_ArgCommaList[index]
                if (comma != null) {
                    printt(comma)
                }
            })
            if (expr.Token_Varg != null) {
                printt(expr.Token_Varg)
            }
            printt(expr.Token_CloseParen)
            printStat(expr.Body)
            printt(expr.Token_End)
        } else if(expr.Type == "VariableExpr") {
            printt(expr.Token)
        } else if(expr.Type == "ParenExpr") {
            printt(expr.Token_OpenParen)
            printExpr(expr.Expression)
            printt(expr.Token_CloseParen)
        } else if(expr.Type == "TableLiteral") {
            printt(expr.Token_OpenBrace)
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    printt(entry.Field)
                    printt(entry.Token_Equals)
                    printExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    printt(entry.Token_OpenBracket)
                    printExpr(entry.Index)
                    printt(entry.Token_CloseBracket)
                    printt(entry.Token_Equals)
                    printExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    printExpr(entry.Value)
                } else {
                    throw "unreachable"
                }
                let sep = expr.Token_SeperatorList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(expr.Token_CloseBrace)
        } else if(expr.Type == "CompoundStat") {
            printStat(expr)
        } else {
            throw `unreachable, type: ${expr.Type}: ${expr}`
        }
    }
    printStat = function(stat) {
        if (stat == null) {
            throw `STAT IS NIL! ${stat}`
        }

        if (stat.Type == "StatList") {
            stat.StatementList.forEach((ch, index) => {
                if (ch === null || ch.Type === null) {
                    return
                }

                ch.Remove = () => {
                    stat.StatementList[index] = null
                }

                printStat(ch)
                if (stat.SemicolonList[index]) {
                    printt(stat.SemicolonList[index])
                }
            })

        } else if(stat.Type == "BreakStat") {
            printt(stat.Token_Break)
        } else if(stat.Type == "ContinueStat") {
            printt(stat.Token_Continue)
        } else if(stat.Type == "ReturnStat") {
            printt(stat.Token_Return)
            stat.ExprList.forEach((expr, index) => {
                printExpr(expr)
                if (stat.Token_CommaList[index]) {
                    printt(stat.Token_CommaList[index])
                }
            })
        } else if(stat.Type == "LocalVarStat") {
            printt(stat.Token_Local)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let comma = stat.Token_VarCommaList[index]
                if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.Token_Equals != null) {
                printt(stat.Token_Equals)
                stat.ExprList.forEach((expr, index) => {
                    printExpr(expr)
                    let comma = stat.Token_ExprCommaList[index]
                     if (comma != null) {
                        printt(comma)
                    }
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            printt(stat.Token_Local)
            printt(stat.FunctionStat.Token_Function)
            printt(stat.FunctionStat.NameChain[0])
            printt(stat.FunctionStat.Token_OpenParen)
            stat.FunctionStat.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = stat.FunctionStat.Token_ArgCommaList[index]
                 if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.FunctionStat.Token_Varg) {
                printt(stat.FunctionStat.Token_Varg)
            }
            printt(stat.FunctionStat.Token_CloseParen)
            printStat(stat.FunctionStat.Body)
            printt(stat.FunctionStat.Token_End)
        } else if(stat.Type == "FunctionStat") {
            printt(stat.Token_Function)
            stat.NameChain.forEach((part, index) => {
                printt(part)
                let sep = stat.Token_NameChainSeperator[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_OpenParen)
            stat.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = stat.Token_ArgCommaList[index]
                 if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.Token_Varg) {
                printt(stat.Token_Varg)
            }
            printt(stat.Token_CloseParen)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "RepeatStat") {
            printt(stat.Token_Repeat)
            printStat(stat.Body)
            printt(stat.Token_Until)
            printExpr(stat.Condition)
        } else if(stat.Type == "GenericForStat") {
            printt(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_In)
            stat.GeneratorList.forEach((expr, index) => {
                printExpr(expr)
                let sep = stat.Token_GeneratorCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "NumericForStat") {
            printt(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {
                    printt(sep);
                }
            })
            printt(stat.Token_Equals)
            stat.RangeList.forEach((expr, index) => {
                printExpr(expr)
                let sep = stat.Token_RangeCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "WhileStat") {
            printt(stat.Token_While)
            printExpr(stat.Condition)
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "DoStat") {
            printt(stat.Token_Do)
            printStat(stat.Body)

            printt(stat.Token_End)
        } else if(stat.Type == "IfStat") {
            printt(stat.Token_If)
            printExpr(stat.Condition)
            printt(stat.Token_Then)
            printStat(stat.Body)
            stat.ElseClauseList.forEach((clause) => {
                printt(clause.Token)
                if (clause.Condition != null) {
                    printExpr(clause.Condition)
                    printt(clause.Token_Then)
                }
                printStat(clause.Body)
            })
            printt(stat.Token_End)
        } else if(stat.Type == "CallExprStat") {
            printExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") { // Fuck you Wally
            printExpr(stat.Lhs)
            printt(stat.Token_Compound)
            printExpr(stat.Rhs)
            stat.Type = "CompoundStat"
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex, index) => {
                printExpr(ex)
                let sep = stat.Token_LhsSeperatorList[index]
                if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Equals)
            stat.Rhs.forEach((ex, index) => {
                printExpr(ex)
                let sep = stat.Token_RhsSeperatorList[index]
                if (sep != null) {
                    printt(sep);
                }
            })
        } else {
            printExpr(stat)
        }
    }
    printStat(ast)
    
    return buffer
}

function FormatAst(ast) {
    let formatStat
    let formatExpr
    let currentIndent = 0
    function applyIndent(token) {
        let indentString = `\n${"\t".repeat(currentIndent)}`
        if (token.LeadingWhite == '' || (token.LeadingWhite.substr(-indentString.length, indentString.length) != indentString)) {
            //token.LeadingWhite = token.LeadingWhite.replace("\n?[\t ]*$") /Remove all \n & \t at end of string
            // idk string patterns in js :(

            let newstr = ""
            let i
            let last
            for (i=token.LeadingWhite.length; i>=0; i--) {
                let cur = token.LeadingWhite.substr(i, 1)
                if (cur == "" || cur.match(/\s/g)) {
                } else {
                    newstr = token.LeadingWhite.substr(0,i+1)
                    break
                }
            }

            token.LeadingWhite = `${newstr}${indentString}`
        }
    }

    function indent() {
        currentIndent++
    }

    function undent() {
        currentIndent--
        assert(currentIndent >= 0, "Undented too far")
    }

    function leadingChar(tk) {
        if (tk.LeadingWhite.length > 0) {
            return tk.LeadingWhite.substr(0,1)
        } else {
            return tk.Source.toString().substr(0,1)
        }
    }

    function padToken(tk) {
        if (!WhiteChars.includes(leadingChar(tk))) {
            tk.LeadingWhite = ' ' + tk.LeadingWhite
        }
    }

    function padExpr(expr) {
        padToken(expr.GetFirstToken())
    }

    function formatBody(openToken, bodyStat, closeToken) {
        indent()
        formatStat(bodyStat)
        undent()
        applyIndent(closeToken)
    }

    formatExpr = function(expr) {
        if (expr.Type == "BinopExpr") {
            formatExpr(expr.Lhs)
            formatExpr(expr.Rhs)
            //if (expr.Token_Op.Source == "..") { // ayeaye
            //    expr.Token_Op.LeadingWhite = " "
             //   expr.Rhs.GetFirstToken.LeadingWhite = " "
            //} else {
                padExpr(expr.Rhs)
                padToken(expr.Token_Op)
            //}
        } else if(expr.Type == "UnopExpr") {
            formatExpr(expr.Rhs)
        } else if(expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral")
        {
            // no
        } else if(expr.Type == "FieldExpr") {
            formatExpr(expr.Base)
        } else if(expr.Type == "IndexExpr") {
            formatExpr(expr.Base)
            formatExpr(expr.Index)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            formatExpr(expr.Base)
            if (expr.Type == "MethodExpr") {

            }
            if (expr.FunctionArguments.CallType == "StringCall") {

            } else if(expr.FunctionArguments.CallType == "ArgCall") {
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    formatExpr(argExpr)
                    if (index > 0) {
                        padExpr(argExpr)
                    }
                    let sep = expr.FunctionArguments.Token_CommaList[index]
                     if (sep != null) {

                    }
                })

            } else if(expr.FunctionArguments.CallType == "TableCall") {
                formatExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            expr.ArgList.forEach((arg, index) => {
                if (index > 0) {
                    padToken(arg)
                }
                let comma = expr.Token_ArgCommaList[index]
                if (comma != null) {

                }
            })

            if (expr.ArgList.length > 0 && expr.Token_Varg != null) {
                padToken(expr.Token_Varg)
            }
            formatBody(expr.Token_CloseParen, expr.Body, expr.Token_End)
        } else if(expr.Type == "VariableExpr") {
            // no
        } else if(expr.Type == "ParenExpr") {
            formatExpr(expr.Expression)
        } else if(expr.Type == "TableLiteral") {
            if (expr.EntryList.length == 0) {

            } else {
                indent()

                let die = 100
                expr.EntryList.forEach((entry, index) => {
                    if (entry.EntryType == "Field") {
                        if (expr.EntryList.length > die) {
                            StripAst(entry.Value)
                        } else {
                            applyIndent(entry.Field)
                        }

                        padToken(entry.Token_Equals)
                        formatExpr(entry.Value)
                        padExpr(entry.Value)
                    } else if(entry.EntryType == "Index") {
                        if (expr.EntryList.length > die)
                            entry.Token_OpenBracket.LeadingWhite = ''
                        else
                            applyIndent(entry.Token_OpenBracket);

                        formatExpr(entry.Index)

                        padToken(entry.Token_Equals)
                        formatExpr(entry.Value)
                        padExpr(entry.Value)
                    } else if(entry.EntryType == "Value") {
                        formatExpr(entry.Value)

                        if (expr.EntryList.length > die) {
                            StripAst(entry.Value)
                        } else {
                            applyIndent(entry.Value.GetFirstToken())
                        }
                    } else {
                        assert(false, "unreachable")
                    }
                    let sep = expr.Token_SeperatorList[index]
                    if (sep != null) {
                        if (expr.EntryList.length > die)
                            sep.LeadingWhite = '';
                    }
                })
                undent()
                if (expr.EntryList.length > die) {
                    expr.Token_CloseBrace.LeadingWhite = ''
                } else {
                    applyIndent(expr.Token_CloseBrace)
                }
            }
        } else if(expr.Type == 'CompoundStat') {
            formatStat(expr)
        } else {
            print(expr)
            throw(`unreachable, type: ${expr.Type}:`+ expr)
        }
    }

    formatStat = function(stat) {
        if (stat.Type == "StatList") {
            stat.StatementList.forEach((stat, index) => {
                if (stat === null || stat.Type === null) {
                    return
                }

                stat.Remove = () => {
                    stat.StatementList[index] = null
                }

                formatStat(stat)
                applyIndent(stat.GetFirstToken())
            })
        } else if(stat.Type == "BreakStat") {
            // no
        } else if(stat.Type == "ContinueStat") {
            // fuck off
        } else if(stat.Type == "ReturnStat") {
            
            stat.ExprList.forEach((expr, index) => {
                formatExpr(expr)
                padExpr(expr)
                if (stat.Token_CommaList[index]) {

                }
            })
        } else if(stat.Type == "LocalVarStat") {
            stat.VarList.forEach((_var, index) => {
                padToken(_var)
                let comma = stat.Token_VarCommaList[index]
                if (comma != null) {

                }
            })
            if (stat.Token_Equals) {
                padToken(stat.Token_Equals)

                let newlist = []
                let newcommalist = []
                stat.ExprList.forEach((expr,index) => {
                    if (expr != null) {
                        if (index < stat.VarList.length) {
                            newlist.push(expr)
                            newcommalist.push(stat.Token_ExprCommaList[index])
                        } else if (expr.Type == "CallExpr" || expr.Type == "ParenExpr" || expr.Type == "VargLiteral" || expr.Type == "BinopExpr" || expr.Type == "UnopExpr") {
                            newlist.push(expr)
                            newcommalist.push(stat.Token_ExprCommaList[index])
                        }
                    }
                })

                stat.ExprList = newlist
                stat.CommaList = newcommalist

                stat.ExprList.forEach((expr,index) => {
                    if (expr != null) {
                        formatExpr(expr)
                        padExpr(expr)
                        let comma = stat.Token_ExprCommaList[index]
                        if (comma != null && stat.ExprList.length-1 == index) {
                            stat.Token_ExprCommaList[index] = null
                        }
                    }
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            padToken(stat.FunctionStat.Token_Function)
            padToken(stat.FunctionStat.NameChain[0])

            stat.FunctionStat.ArgList.forEach((arg, index) => {
                if (index > 0) {
                    padToken(arg)
                }
                let comma = stat.FunctionStat.Token_ArgCommaList[index]
            })

            if (stat.FunctionStat.ArgList.length > 0 && stat.FunctionStat.Token_Varg) {
                padToken(stat.FunctionStat.Token_Varg)
            }

            formatBody(stat.FunctionStat.Token_CloseParen, stat.FunctionStat.Body, stat.FunctionStat.Token_End)
        } else if(stat.Type == "FunctionStat") {
            stat.NameChain.forEach((part, index) => {
                if (index == 0) {
                    padToken(part)
                }
                let sep = stat.Token_NameChainSeperator[index]
                if (sep != null) {

                }
            })

            stat.ArgList.forEach((arg, index) => {
                if (index > 0) {
                    padToken(arg)
                }
                let comma = stat.Token_ArgCommaList[index]
                if (comma != null) {

                }
            })

            if (stat.ArgList.length > 0 && stat.Token_Varg) {
                padToken(stat.Token_Varg)
            }

            formatBody(stat.Token_CloseParen, stat.Body, stat.Token_End)
        } else if(stat.Type == "RepeatStat") {
            formatBody(stat.Token_Repeat, stat.Body, stat.Token_Until)
            formatExpr(stat.Condition)
            padExpr(stat.Condition)
        } else if(stat.Type == "GenericForStat") {
            stat.VarList.forEach((_var, index) => {
                padToken(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {

                }
            })
            padToken(stat.Token_In)
            stat.GeneratorList.forEach((expr, index) => {
                formatExpr(expr)
                padExpr(expr)
                let sep = stat.Token_GeneratorCommaList[index]
                 if (sep != null) {

                }
            })
            padToken(stat.Token_Do)
            formatBody(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "NumericForStat") {
            stat.VarList.forEach((_var, index) => {
                padToken(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {

                }
            })
            padToken(stat.Token_Equals)
            stat.RangeList.forEach((expr, index) => {
                formatExpr(expr)
                padExpr(expr)
                let sep = stat.Token_RangeCommaList[index]
                 if (sep != null) {

                }
            })
            padToken(stat.Token_Do)
            formatBody(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "WhileStat") {
            formatExpr(stat.Condition)
            padExpr(stat.Condition)
            padToken(stat.Token_Do)
            formatBody(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "DoStat") {
            formatBody(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "IfStat") {
            formatExpr(stat.Condition)
            padExpr(stat.Condition)
            padToken(stat.Token_Then)

            let lastBodyOpen = stat.Token_Then
            let lastBody = stat.Body

            stat.ElseClauseList.forEach((clause) => {
                formatBody(lastBodyOpen, lastBody, clause.Token)
                lastBodyOpen = clause.Token

                if (clause.Condition != null) {
                    formatExpr(clause.Condition)
                    padExpr(clause.Condition)
                    padToken(clause.Token_Then)
                    lastBodyOpen = clause.Token_Then
                }
                lastBody = clause.Body
            })

            formatBody(lastBodyOpen, lastBody, stat.Token_End)
        } else if(stat.Type == "CallExprStat") {
            formatExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") {
            formatExpr(stat.Lhs)
            formatExpr(stat.Rhs)

            padExpr(stat.Lhs)
            padExpr(stat.Rhs)
            padToken(stat.Token_Compound)
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex, index) => {
                formatExpr(ex)
                if (index > 0) {
                    padExpr(ex)
                }
                let sep = stat.Token_LhsSeperatorList[index]
                 if (sep != null) {

                }
            })
            padToken(stat.Token_Equals)
            stat.Rhs.forEach((ex, index) => {
                formatExpr(ex)
                padExpr(ex)
                let sep = stat.Token_RhsSeperatorList[index]
                 if (sep != null) {

                }
            })
        } else {
            assert(false, "Unreachable")
        }
    }

    formatStat(ast)
}

function StripAst(ast) {
    let stripStat
    let stripExpr
    function stript(token) {
        token.LeadingWhite = ''
    }
    function joint(tokenA, tokenB, shit = false) {
        stript(tokenB)

        let lastCh = (typeof tokenA.Source == 'string' ? tokenA.Source : tokenA.Source.toString()).substr(tokenA.Source.length - 1,1)
        let firstCh = (typeof tokenB.Source == 'string' ? tokenB.Source : tokenB.Source.toString()).substr(0,1)
        
        if ((lastCh == "-" && firstCh == "-") || (AllIdentChars.includes(lastCh) && AllIdentChars.includes(firstCh)) || (shit && lastCh == ')' && firstCh == '(')) {
            tokenB.LeadingWhite = shit ? ';' : ' '
        } else {
            tokenB.LeadingWhite = ""
        }
    }

    function bodyjoint(open, body, close) {
        stripStat(body)
        stript(close)
        let bodyFirst = body.GetFirstToken()
        let bodyLast = body.GetLastToken()

        if (bodyFirst != null) {
            joint(open, bodyFirst)
            joint(bodyLast, close)
        } else {
            joint(open, close)
        }
    }

    stripExpr = function(expr) {
        if (expr.Type == "BinopExpr") {
            stripExpr(expr.Lhs)
            stript(expr.Token_Op)
            stripExpr(expr.Rhs)

            joint(expr.Token_Op, expr.Rhs.GetFirstToken())
            joint(expr.Lhs.GetLastToken(), expr.Token_Op)
        } else if(expr.Type == "UnopExpr") {
            stript(expr.Token_Op)
            stripExpr(expr.Rhs)

            joint(expr.Token_Op, expr.Rhs.GetFirstToken())
        } else if(expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral")
        {
            stript(expr.Token)


        } else if(expr.Type == "FieldExpr") {
            stripExpr(expr.Base)
            stript(expr.Token_Dot)
            stript(expr.Field)
        } else if(expr.Type == "IndexExpr") {
            stripExpr(expr.Base)
            stript(expr.Token_OpenBracket)
            stripExpr(expr.Index)
            stript(expr.Token_CloseBracket)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            stripExpr(expr.Base)
            if (expr.Type == "MethodExpr") {
                stript(expr.Token_Colon)
                stript(expr.Method)
            }
            if (expr.FunctionArguments.CallType == "StringCall") {
                stript(expr.FunctionArguments.Token)
            } else if(expr.FunctionArguments.CallType == "ArgCall") {
                stript(expr.FunctionArguments.Token_OpenParen)
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    stripExpr(argExpr)
                    let sep = expr.FunctionArguments.Token_CommaList[index]
                    if (sep != null) {
                        stript(sep)
                    }
                })
                stript(expr.FunctionArguments.Token_CloseParen)
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                stripExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            stript(expr.Token_Function)
            stript(expr.Token_OpenParen)
            expr.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = expr.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (expr.Token_Varg != null) {
                stript(expr.Token_Varg)
            }
            stript(expr.Token_CloseParen)
            bodyjoint(expr.Token_CloseParen, expr.Body, expr.Token_End)
        } else if(expr.Type == "VariableExpr") {
            stript(expr.Token)
        } else if(expr.Type == "ParenExpr") {
            stript(expr.Token_OpenParen)
            stripExpr(expr.Expression)
            stript(expr.Token_CloseParen)
        } else if(expr.Type == "TableLiteral") {
            stript(expr.Token_OpenBrace)
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    stript(entry.Field)
                    stript(entry.Token_Equals)
                    stripExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    stript(entry.Token_OpenBracket)
                    stripExpr(entry.Index)
                    stript(entry.Token_CloseBracket)
                    stript(entry.Token_Equals)
                    stripExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    stripExpr(entry.Value)
                } else {
                    assert(false, "unreachable")
                }
                let sep = expr.Token_SeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            
            expr.Token_SeperatorList[expr.EntryList.length-1] = null
            stript(expr.Token_CloseBrace)
        } else {
            throw(`unreachable, type: ${expr.Type}:${expr}  ${console.trace()}`)
        }
    }
    
    stripStat = function(stat) {
        if (stat.Type == "StatList") {
            let i
            for (i=0; i<=stat.StatementList.length;i++) {
                let chStat = stat.StatementList[i]
                if (chStat == null) continue;
                
                stripStat(chStat)
                stript(chStat.GetFirstToken())
                let lastChStat = stat.StatementList[i-1]
                if (lastChStat != null) {

                    if (stat.SemicolonList[i-1]
                        && lastChStat.GetLastToken().Source != ")" || chStat.GetFirstToken().Source != ")") 
                    {
                        stat.SemicolonList[i-1] = null
                    }

                    if (!stat.SemicolonList[i-1]) {
                        joint(lastChStat.GetLastToken(), chStat.GetFirstToken(), true)
                    }
                }
            }

            stat.SemicolonList[stat.StatementList.length-1] = null
            if (stat.StatementList.length > 0) {
                stript(stat.StatementList[0].GetFirstToken())
            }
        } else if(stat.Type == "BreakStat") {
            stript(stat.Token_Break)
        } else if(stat.Type == "ContinueStat") {
            stript(stat.Token_Continue)
        } else if(stat.Type == "ReturnStat") {
            stript(stat.Token_Return)
            stat.ExprList.forEach((expr, index) => {
                stripExpr(expr)
                if (stat.Token_CommaList[index] != null) {
                    stript(stat.Token_CommaList[index])
                }
            })
            if (stat.ExprList.length > 0) {
                joint(stat.Token_Return, stat.ExprList[0].GetFirstToken())
            }
        } else if(stat.Type == "LocalVarStat") {
            stript(stat.Token_Local)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_Local, _var)
                } else {
                    stript(_var)
                }
                let comma = stat.Token_VarCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (stat.Token_Equals != null) {
                stript(stat.Token_Equals)
                stat.ExprList.forEach((expr, index) => {
                    stripExpr(expr)
                    let comma = stat.Token_ExprCommaList[index]
                    if (comma != null) {
                        stript(comma)
                    }
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            stript(stat.Token_Local)
            joint(stat.Token_Local, stat.FunctionStat.Token_Function)
            joint(stat.FunctionStat.Token_Function, stat.FunctionStat.NameChain[0])
            joint(stat.FunctionStat.NameChain[0], stat.FunctionStat.Token_OpenParen)

            stat.FunctionStat.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = stat.FunctionStat.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (stat.FunctionStat.Token_Varg) {
                stript(stat.FunctionStat.Token_Varg)
            }
            stript(stat.FunctionStat.Token_CloseParen)
            bodyjoint(stat.FunctionStat.Token_CloseParen, stat.FunctionStat.Body, stat.FunctionStat.Token_End)
        } else if(stat.Type == "FunctionStat") {
            stript(stat.Token_Function)
            stat.NameChain.forEach((part, index) => {
                if (index == 0) {
                    joint(stat.Token_Function, part)
                } else {
                    stript(part)
                }
                let sep = stat.Token_NameChainSeperator[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            stript(stat.Token_OpenParen)
            stat.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = stat.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })

            if (stat.Token_Varg) {
                stript(stat.Token_Varg)
            }
            stript(stat.Token_CloseParen)
            bodyjoint(stat.Token_CloseParen, stat.Body, stat.Token_End)
        } else if(stat.Type == "RepeatStat") {
            stript(stat.Token_Repeat)
            bodyjoint(stat.Token_Repeat, stat.Body, stat.Token_Until)
            stripExpr(stat.Condition)
            joint(stat.Token_Until, stat.Condition.GetFirstToken())
        } else if(stat.Type == "GenericForStat") {
            stript(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_For, _var)
                } else {
                    stript(_var)
                }
                let sep = stat.Token_VarCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.VarList[stat.VarList.length-1], stat.Token_In)
            stat.GeneratorList.forEach((expr, index) => {
                stripExpr(expr)
                if (index == 0) {
                    joint(stat.Token_In, expr.GetFirstToken())
                }
                let sep = stat.Token_GeneratorCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.GeneratorList[stat.GeneratorList.length-1].GetLastToken(), stat.Token_Do)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "NumericForStat") {
            stript(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_For, _var)
                } else {
                    stript(_var)
                }
                let sep = stat.Token_VarCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.VarList[stat.VarList.length-1], stat.Token_Equals)
            stat.RangeList.forEach((expr, index) => {
                stripExpr(expr)
                if (index == 0) {
                    joint(stat.Token_Equals, expr.GetFirstToken())
                }
                let sep = stat.Token_RangeCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.RangeList[stat.RangeList.length-1].GetLastToken(), stat.Token_Do)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "WhileStat") {
            stript(stat.Token_While)
            stripExpr(stat.Condition)
            stript(stat.Token_Do)
            joint(stat.Token_While, stat.Condition.GetFirstToken())
            joint(stat.Condition.GetLastToken(), stat.Token_Do)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "DoStat") {
            stript(stat.Token_Do)
            stript(stat.Token_End)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "IfStat") {
            stript(stat.Token_If)
            stripExpr(stat.Condition)
            joint(stat.Token_If, stat.Condition.GetFirstToken())
            joint(stat.Condition.GetLastToken(), stat.Token_Then)

            let lastBodyOpen = stat.Token_Then
            let lastBody = stat.Body

            stat.ElseClauseList.forEach((clause, i) => {
                bodyjoint(lastBodyOpen, lastBody, clause.Token)
                lastBodyOpen = clause.Token

                if (clause.Condition != null) {
                    stripExpr(clause.Condition)
                    joint(clause.Token, clause.Condition.GetFirstToken())
                    joint(clause.Condition.GetLastToken(), clause.Token_Then)
                    lastBodyOpen = clause.Token_Then
                }

                stripStat(clause.Body)
                lastBody = clause.Body            
            })

            bodyjoint(lastBodyOpen, lastBody, stat.Token_End)
        } else if(stat.Type == "CallExprStat") {
            stripExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") {
            stripExpr(stat.Lhs)
            stript(stat.Token_Compound)
            stripExpr(stat.Rhs)

            joint(stat.Lhs.GetLastToken(), stat.Token_Compound)
            joint(stat.Token_Compound, stat.Rhs.GetFirstToken())

            lastBody = stat.Body
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex, index) => {
                stripExpr(ex)
                let sep = stat.Token_LhsSeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            stript(stat.Token_Equals)
            stat.Rhs.forEach((ex, index) => {
                stripExpr(ex)
                let sep = stat.Token_RhsSeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
        } else {
            return stripExpr(stat)
            //print(`unreachable, type: ${stat.Type}`,stat)
            //throw(`unreachable, type: ${stat.Type}:${stat}`)
        }
    }

    stripStat(ast)
}


let VarDigits = []

let i
for (i="a".charCodeAt(); i<="z".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
for (i="A".charCodeAt(); i<="Z".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
for (i="0".charCodeAt(); i<="9".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
VarDigits.push("_")

let VarStartDigits = []
for (i="a".charCodeAt(); i<="z".charCodeAt(); i++) VarStartDigits.push(String.fromCharCode(i));
for (i="A".charCodeAt(); i<="Z".charCodeAt(); i++) VarStartDigits.push(String.fromCharCode(i));


function indexToVarName(index) {
    let id = ""
    let d = index % VarStartDigits.length
    index = (index - d) / VarStartDigits.length
    id = `${id}${VarStartDigits[d + 1]}`
    while (index > 0) {
        let d = index % VarDigits.length
        index = (index - d) / VarDigits.length
        id = `${id}${VarDigits[d+1]}`
    }
    return id
}

function BeautifyVariables(globalScope, rootScope, renameGlobals) {
    let externalGlobals = []
     globalScope.forEach((_var) => {
        if (!_var.AssignedTo || !renameGlobals) {
            externalGlobals[_var.Name] = true
        }
    })

    let localNumber = 1
    let globalNumber = 1
    function setVarName(_var, name) {
        _var.Name = name
        _var.RenameList.forEach((setter) => {
            setter(name)
        })
    }
    
    if (renameGlobals) {
        let names = {}
        globalScope.forEach((_var) => {
            if (_var.AssignedTo && !_var.ChangedName) {
                names[_var.Name] = names[_var.Name] || `G_${globalNumber}_`
                _var.ChangedName = true
                setVarName(_var, names[_var.Name])
                globalNumber++
            }
        })
    }

    function modify(scope) {
        scope.VariableList.forEach((_var) => {
            let name = `L_${localNumber}_`
            if (_var.Info.Type == "Argument") {
                name = `${name}arg${_var.Info.Index}`
            } else if(_var.Info.Type == "LocalFunction") {
                name = `${name}func`
            } else if(_var.Info.Type == "ForRange") {
                name = `${name}forvar${_var.Info.Index}`
            }
            setVarName(_var, name)
            localNumber++
        })
        scope.ChildScopeList.forEach((scope1) => {
            modify(scope1)
        })
    }
    
    modify(rootScope)
}

function MinifyVariables_2(globalScope, rootScope, renameGlobals) {
    let globalUsedNames = []
    for (var [kw, _] of Object.entries(Keywords)) {
        globalUsedNames[kw] = true
    }

    let allVariables = []
    let allLocalVariables = []
    
    globalScope.forEach((_var) => {
        if (_var.AssignedTo && renameGlobals) {
            allVariables.push(_var)
        } else {
            globalUsedNames[_var.Name] = true
        }
    })

    function addFrom(scope) {
        scope.VariableList.forEach((_var) => {
            allVariables.push(_var)
            allLocalVariables.push(_var)
        })
        scope.ChildScopeList.forEach((childScope) => {
            addFrom(childScope)
        })
    }
    addFrom(rootScope)

    allVariables.forEach((_var) => {
        _var.UsedNameArray = []
    })

    allVariables.sort((a, b) => a - b)

    let nextValidNameIndex = 0
    let varNamesLazy = []

    function varIndexToValidName(i) {
        let name = varNamesLazy[i]
        if (name == null) {
            name = indexToVarName(nextValidNameIndex)
            nextValidNameIndex++
            while (globalUsedNames[name]) {
                name = indexToVarName(nextValidNameIndex)
                nextValidNameIndex++  
            }
            varNamesLazy[i] = name
        }
        return name
    }

    allVariables.forEach((_var, _) => {
        _var.Renamed = true
        
        let i = 0
        while (_var.UsedNameArray[i]) {
            i++
        }

        _var.Rename(varIndexToValidName(i))

        if (_var.Scope) {

            allVariables.forEach((otherVar) => {
                if (!otherVar.Renamed) {
                    if (!otherVar.Scope || otherVar.Scope.Depth < _var.Scope.Depth) {
                        otherVar.ReferenceLocationList.some((refAt) => {
                            if (refAt >= _var.BeginLocation && refAt <= _var.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }
                            return false
                        })
                    } else if(otherVar.Scope.Depth > _var.Scope.Depth) {
                        _var.ReferenceLocationList.some((refAt) => {
                            if (refAt >= otherVar.BeginLocation && refAt <= otherVar.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }
                            return false
                        })
                    } else {
                        if (_var.BeginLocation < otherVar.EndLocation && _var.EndLocation > otherVar.BeginLocation) {
                           otherVar.UsedNameArray[i] = true
                        }
                    }
                }
            })
        } else {
            allVariables.forEach((otherVar) => {
                if (!otherVar.Renamed) {
                    if (otherVar.Type == "Global") {
                        otherVar.UsedNameArray[i] = true
                    } else if(otherVar.Type == "Local") {

                        _var.ReferenceLocationList.some((refAt) => {
                            if (refAt >= otherVar.BeginLocation && refAt <= otherVar.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }

                            return false
                        })
                    } else {
                        throw "Unreachable"
                    }
                }
            })
        }
    })
}



// hi

let luaminp = {}

luaminp.Beautify = function(scr, options) {
    let ast = CreateLuaParser(scr)
    let [glb, root] = AddVariableInfo(ast)

    if (options.RenameVariables) {
        BeautifyVariables(glb, root, options.RenameGlobals)
    }

    if (options.SolveMath == true) {
        SolveMath(ast) // oboy
    }

    FormatAst(ast)

    let result = PrintAst(ast)
    return result
}


luaminp.Minify = function(scr, options) {

    let ast = CreateLuaParser(scr)
    let [glb, root] = AddVariableInfo(ast)

    if (options.RenameVariables == true) {
        MinifyVariables_2(glb, root, options.RenameGlobals)
    }

    if (options.SolveMath == true) {
        SolveMath(ast) // oboy
    }

    StripAst(ast)

    let result = PrintAst(ast)

    return result
}


module.exports.Beautify = luaminp.Beautify
module.exports.Minify = luaminp.Minify
module.exports.Uglify = luaminp.Uglify



/src/minify.js - Lua minification

/*
    Stravant thing in js
    Written by Herrtt (originally by Stravant)
*/

// I copied some comments
// no, it was not worth it
// please leave me alone
// I tried to copy+paste all comments, but no. I got bored.
// Be happy.

let quotes = require('./SunTzu.json').quotes
const date = new Date()

let debug = false;
let lastTime = null;//new Date().getTime();
const print = debug ? x => {
    let newT = new Date().getTime()
    let diff = newT - (lastTime === null ? newT : lastTime)
    lastTime = newT
    console.log(`| ms since l.p.`, diff, `| :`, x)
} : () => null;
const assert = function(a,b) {
    if (!a) {
        throw b
    }
}

function parseFloat(str, radix) { // Thanks stackoverflow (hex numbers with decimal)
    if (!str) return 0;
    var parts = str.toString().split(".");
    if (parts.length > 1) {
        return parseInt(parts[0], radix) + parseInt(parts[1], radix) / Math.pow(radix, parts[1].length);
    }
    return parseInt(parts[0], radix);
}

/** 
 * 
 * regex to make arr : (arr)\[(\S*)\]
 * replace value : $1.includes($2)
 * 
*/

let WhiteChars = [
    ' ', 
    '\n', 
    '\t', 
    '\r'
]


let Main_CharacterForEscape = {
    'r': '\r', 
    'n': '\n',
    't': '\t',
    '"': '"',
    "'": "'",
    '\\': '\\',
}

const CharacterForEscape = new Proxy(Main_CharacterForEscape, { 
    get(_, x) { return parseFloat(x) }
})

let AllIdentStartChars = [
    'A',    'B',    'C',    'D',
    'E',    'F',    'G',    'H',
    'I',    'J',    'K',    'L',
    'M',    'N',    'O',    'P',
    'Q',    'R',    'S',    'T',
    'U',    'V',    'W',    'X',
    'Y',    'Z',    '_',    'a',
    'b',    'c',    'd',    'e',
    'f',    'g',    'h',    'i',
    'j',    'k',    'l',    'm',
    'n',    'o',    'p',    'q',
    'r',    's',    't',    'u',
    'v',    'w',    'x',    'y',
    'z'
]

let AllIdentChars = [
    '0',    '1',    '2',    '3',
    '4',    '5',    '6',    '7',
    '8',    '9',    
    
    
    'A',    'B',
    'C',    'D',    'E',    'F',
    'G',    'H',    'I',    'J',
    'K',    'L',    'M',    'N',
    'O',    'P',    'Q',    'R',
    'S',    'T',    'U',    'V',
    'W',    'X',    'Y',    'Z',
    '_',    'a',    'b',    'c',
    'd',    'e',    'f',    'g',
    't',    'u',    'v',    'w',
    'h',    'i',    'j',    'k',
    'l',    'm',    'n',    'o',
    'p',    'q',    'r',    's',
    'x',    'y',    'z',     // this was actually fucking retarded to add, pls dont do this to me
]

let Digits = [
    '0','1','2','3',
    '4','5','6','7',
    '8','9',
]

let HexDigits = [
    //digits
    '0','1','2','3',
    '4','5','6','7',
    '8','9',

    //letters
    'a','b','c','d','e','f',
    'A','B','C','D','E','F',
]

let BinaryDigits = [
    '0', '1' // lol
]

let Symbols = [
    '+', '-', '*', ')', ';',  
    '/', '^', '%', '#',
    ',', '{', '}', ':',
    '[', ']', '(','.',
]

let EqualSymbols = [
    '~', '=', '>', '<'
]

let CompoundSymbols = [
    '+', '-', '*', '/', '^', '..', '%'
]

let Compounds = [
    '+=', '-=', '*=', '/=', '^=', '..=', '%='
]

let Keywords = [
    'and',      'break',    'do',   'else', 
    'elseif',   'end',      'false','for',
    'function', 'goto',     'if',   'in',
    'local',    'nil',      'not',  'or', 
    'repeat',   'return',   'then', 'true', 
    'until',    'while', 'continue'
]

let BlockFollowKeyword = [
    'else',     'elseif', 
    'until',    'end'
]

let UnopSet = [
    '-',    'not',  '#',
]

let BinopSet = [
    '+',    '-',     '*',   '/',    '%',    '^',    '#',    //algorithmic
    
    '..',   '.',     ':',   //dots / colons
    
    '>',    '<',     '<=',  '>=',   '~=',   '==',  //arrows / conditional
    
    '+=', '-=', '*=', '/=', '%=', '^=', '..=', // compounds

	'and',  'or'    // conditional 
]

/* let GlobalRenameIgnore = {
} //unused */
let BinaryPriority = {
    '+': [6, 6],
    '-': [6, 6],
    '*': [7, 7],
    '/': [7, 7],
    '%': [7, 7],
    '^': [10, 9],
    '..': [5, 4],
    '==': [3, 3],
    '~=': [3, 3],
    '>': [3, 3],
    '<': [3, 3],
    '>=': [3, 3],
    '<=': [3, 3],
    '+=': [3, 3],
    '-=': [3, 3],
    '*=': [3, 3],
    '/=': [3, 3],
    '^=': [3, 3],
    '%=': [3, 3],
    '..=': [3, 3],
    'and': [2, 2],
    'or': [1, 1],
}

let UnaryPriority = 8
// Eof, Ident, KeyWord, Number, String, Symbol

function CreateLuaTokenStream(text) {
    // Tracking for the current position in the buffer, and
    // the current line / character we are on

    let p = 0
    let length = text.length

    // Output buffer for tokens
    let tokenBuffer = []

    // Get a character or '' if at eof
    function look(n) {
        n = n || 0
        if (p <= length) {
            return text.substr(p + n, 1)
        } else {
            return ''
        }
    }

    function get() {
        if (p <= length) {
            let c = text.substr(p, 1)
            p++
            return c
        } else {
            return ''
        }
    }

    // Error
    function error(str) {
        let q = 0
        let line = 1
        let char = 1
        while (q <= p) {
            if (text.substr(q,1) == '\n') {
                line++
                char = 1
            } else {
                char++
            }
        }
        let i_;
        for (i_ = 0; i_ < tokenBuffer; i_++) {
            let token = tokenBuffer[i_]
            print(`${token.Type}<${token.Source}>`)
        }
        throw `file<${line}:${char}>: ${str}`
    }

    // Consume a long data with equals count of `eqcount`
    function longdata(eqcount) {
        while (true) {
            let c = get()
            if (c == '') {
                error("Unfinished long string.")
            } else if(c == ']') {
                let done = true // Until contested
                let startp = p
                while (look() == '=') {
                    p++
                }
                if (look() == '[') {
                    p++
                    return p - startp - 1
                }

                if (done && get() == ']') {
                    return
                }
            }
        }
    }


    // Get the opening part for a long data `[` `=`` * `[`
    // Precondition: The first `[` has been consumed
    // Return: nil or the equals count

    function getopen() {
        let startp = p
        while (look() == '=') {
            p++
        }
        if (look() == '[') {
            p++
            return p - startp - 1
        } else {
            p = startp
            return
        }
    }


    // Add token
    let whiteStart = 0
    let tokenStart = 0
    let tokens = 0
    function token(type) {
        tokens++

        let src = text.substr(tokenStart, (p - tokenStart))
        let ntype = null
        if (type == "Number") {
            if (src.substr(0,2) == "0x") {
                ntype = 'hex'
                src = parseInt(src, 16)
            } else if(src.substr(0,2) == "0b") {
                ntype = 'bin'
                src = parseInt(src.substr(2), 2)
            }
        }
        let tk = {
            Type: type,
            //LeadingWhite: text.substr(whiteStart, (tokenStart - whiteStart)),
            Source: src
        }
        if (ntype !== null) {
            tk.NType = ntype
        }
        tokenBuffer.push(tk)

        whiteStart = p
        tokenStart = p
        return tk
    }

    // Parse tokens loop

    print("Lexing tokens")
    while (true) {
        // Mark the whitespace start
        whiteStart = p
        while (true) { // Whitespaces
            let c = look()
            if (c == '') {
                break
            } else if(c == '-') {

                if (look(1) == "-") {
                    p += 2

                    // Consume comment body
                    if (look() == "[") {

                        p++
                        let eqcount = getopen()
                        if (eqcount != null) {
                            // Long comment body
                            longdata(eqcount)
                            whiteStart = p
                        } else {
                            // Normal comment body
                            while (true) {
                                let c2 = get()
                                if (c2 == "" || c2 == "\n") {
                                    //whiteStart = p
                                    break
                                }
                            }
                        }
                    } else {
                        // Normal comment body
                        while (true) {
                            let c2 = get()
                            if (c2 == "" || c2 == "\n") {
                                //whiteStart = p
                                break
                            }
                        }
                    }
                } else {
                    break
                }
            } else if(WhiteChars.includes(c)) {
                p++
            } else {
                break
            }
        }

        // Mark the token start
        tokenStart = p

        // Switch on token type
        let c1 = get()
        if (c1 == '') {
            // End of file
            token('Eof')
            break
        } else if(c1 == '\'' || c1 == '\"') {
            // String constant
            
            while (true) {
                let c2 = get()

                if (c2 == '\\') {
                    let c3 = get()
                    if (Digits.includes(c3)) {
                        while (Digits.includes(look())) {
                            c3 += get()
                        }
                    }

                    let esc = CharacterForEscape[c3]

                    if (esc == null) {
                        throw (`Invalid Escape Sequence \`${c3}\`.`)
                    }
                } else if(c2 == c1) {
                    break
                } else if(c2 == "") {
                    throw ("Unfinished string!")
                }
            }
            token('String')
        } else if(AllIdentStartChars.includes(c1)) {
            // Ident or keyword
            while (AllIdentChars.includes(look())) {
                p++
            }

            if (Keywords.includes(text.substr(tokenStart, (p - tokenStart)))) {
                token("Keyword")
            } else {
                token("Ident")
            }
            
        } else if(Digits.includes(c1) || (c1 == '.' && Digits.includes(look()))) {
            // Number
            if (c1 == '0' && look() == 'x') {
                p++
                // Hex number
                while (HexDigits.includes(look())) {
                    p++
                }
            } else if (c1 == '0' && look() == 'b') {
                p++
                // Binary number
                while (BinaryDigits.includes(look())) {
                    p++
                }
            } else {
                // Normal number
                while (Digits.includes(look())) {
                    p++
                }

                if (look() == '.') {
                    // With decimal point
                    p++
                    while (Digits.includes(look())) {
                        p++
                    }
                }

                if (look() == 'e' || look() == 'E') {
                    // With exponent
                    p++
                    if (look() == '-') {
                        p++
                    }
                    while (Digits.includes(look())) {
                        p++
                    }
                }
            }
            token("Number")
        } else if(c1 == '[') {
            // Symbol or Long String
            let eqCount = getopen()
            if (eqCount != null) {
                print("longdata")
                // Long String
                longdata(eqCount)
                token("String")
            } else {
                // Symbol
                token("Symbol")
            }
        } else if(c1 == '.') {
            // Greedily consume up to 3 `.` for . / .. / ... tokens / ..= compound
            if (look() == '.') {
                get()
                if (look() == '.') {
                    get()
                } else if(look() == '=') {
                    get()
                }
            }
            token("Symbol")
        } else if(EqualSymbols.includes(c1)) {
            if (look() == "=") {
                p++
            }
            token("Symbol")
        } else if(CompoundSymbols.includes(c1) && look() == '=') {
            get()
            token('Symbol')
        } else if(Symbols.includes(c1)) {
            token("Symbol")
        } else {
            throw(`Bad symbol \`${c1}\` in source. ${p}`)
        }
    }
    print("Finished parsing tokens")

    return tokenBuffer
}

//Removelater


function CreateLuaParser(text) {
    // Token stream and pointer into it
    print("Creating tokens stream")
    let tokens = CreateLuaTokenStream(text)

    let p = 0
    function get() {
        let tok = tokens[p]
        if (p < tokens.length) {
            p++
        }
        return tok
    }
    function peek(n) {
        n = p + (n || 0)
        return tokens[n] || tokens[tokens.length - 1]
    }

    function getTokenStartPosition(token) {
        let line = 1
        let char = 0
        let tkNum = 0
        while (true) {
            let tk = tokens[tkNum]
            let text
            if (tk == token) {
                text = ' '
            } else {
                text = ' ' + tk.Source
            }

            for (i=0; i<=text.length; i++) {
                let c = text.substr(i, 1)
                if (c == '\n') {
                    line++
                    char = 0
                } else {
                    char++
                }
            }
            
            if (tk == token) {
                break
            }
            tkNum++
        }
        return `${line}:${char+1}`
    }

    function debugMark() {
        let tk = peek()
        return `<${tk.Type} \`${tk.Source}\`> at: ${getTokenStartPosition(tk)}`
    }

    function isBlockFollow() {
        let tok = peek()
        return tok.Type == 'Eof' || (tok.Type == 'Keyword' && BlockFollowKeyword.includes(tok.Source))   
    }

    function isUnop() {
        return UnopSet.includes(peek().Source) || false
    }

    function isBinop() {
        return BinopSet.includes(peek().Source) || false
    }

    function expect(type, source) {
        let tk = peek()
        if (tk.Type == type && (source == null || tk.Source == source)) {
            return get()
        } else {
            let i
            for (i=-3; i<=3; i++) {
                print(`Tokens[${i}] = \`${peek(i).Source}\``)
            }
            if (source) {
                let a = `${getTokenStartPosition(tk)}: \`${source}\` expected.`
                throw a
            } else {
                let a = `${getTokenStartPosition(tk)}: ${type} expected.`
                throw a
            }
        }
    }

    function MkNode(node) {
        let getf = node.GetFirstToken
        let getl = node.GetLastToken

        let self = node
        node.GetFirstToken = function() {
            let t = getf(self)
            assert(t)
            return t
        }

        node.GetLastToken = function() {
            let t = getl(self)
            assert(t)
            return t
        }

        return node
    }

    let block
    let expr

    function exprlist() {
        let exprList = [expr()]
        let commaList = []
        while (peek().Source == ",") {
            commaList.push(get())
            exprList.push(expr())
        }
        return [exprList, commaList]
    }

    function prefixexpr() {
        let tk = peek()
        if (tk.Source == '(') {
            let oparenTk = get()
            let inner = expr()
            let cparenTk = expect('Symbol', ')')
            let node
            node = MkNode({
                'Type': 'ParenExpr',
                'Expression': inner,
                'Token_OpenParen': oparenTk,
                'Token_CloseParen': cparenTk,
                'GetFirstToken': () => node.Token_OpenParen,
                'GetLastToken': () => node.Token_CloseParen,
            })
            return node
        } else if(tk.Type == "Ident") {
            let node
            node = MkNode({
                'Type': 'VariableExpr',
                'Token': get(),
                'GetFirstToken': () => node.Token,
                'GetLastToken': () => node.Token,
            })

            /*if (locals[node.Token.Source] != null) {
                locals[node.Token.Source].Tokens.push(node.Token)
                locals[node.Token.Source].UseCountIncrease()
            } else if(upvals[node.Token.Source] != null) {
                upvals[node.Token.Source].Tokens.push(node.Token)
                upvals[node.Token.Source].UseCountIncrease()
            }*/

            return node
        } else {
            print(debugMark())
            let a = (`${getTokenStartPosition(tk)}: Unexpected symbol. ${tk.Type} ${tk.Source}`)
            throw a
        }
    }

    function tableexpr() {
        let obrace = expect("Symbol", "{")
        let entries = []
        let seperators = []
        while (peek().Source != "}") {
            if (peek().Source == '[') {
                // Index
                let obrac = get()
                let index = expr()
                let cbrac = expect("Symbol", "]")
                let eq = expect("Symbol", "=")
                let value = expr()

                indx = index.Token && index.Token.Source
                val = value

                entries.push({
                    "EntryType": "Index",
                    "Index": index,
                    "Value": value,
                    "Token_OpenBracket": obrac,
                    "Token_CloseBracket": cbrac,
                    "Token_Equals": eq,
                })
            } else if(peek().Type == "Ident" && peek(1).Source == "=") {
                // Field
                let field = get()
                let eq = get()
                let value = expr()
                
                indx = field
                val = value
                entries.push({
                    "EntryType": "Field",
                    "Field": field,
                    "Value": value,
                    "Token_Equals": eq,
                })
            } else {
                // Value
        
                let value = expr()
                entries.push({
                    "EntryType": "Value",
                    "Value": value,
                })
            }

            if (peek().Source == "," || peek().Source == ";") {
                seperators.push(get())
            } else {
                break
            }
        }

        let cbrace = expect("Symbol", "}")
        let node
        node = MkNode({
            "Type": "TableLiteral",
            "EntryList": entries,
            "Token_SeperatorList": seperators,
            "Token_OpenBrace": obrace,
            "Token_CloseBrace": cbrace,
            "GetFirstToken": () => node.Token_OpenBrace,
            "GetLastToken": () => node.Token_CloseBrace,
        })
        return node
    }


    function varlist(acceptVarg) {
        let varList = []
        let commaList = []
        if (peek().Type == "Ident") {
            varList.push(get())
        } else if(peek().Source == "..." && acceptVarg) {
            return [varList, commaList, get()]
        }
        while (peek().Source == ",") {
            commaList.push(get())
            if (peek().Source == "..." && acceptVarg) {
                return [varList, commaList, get()]
            } else {
                let id = expect("Ident")
                varList.push(id)
            }
        }
        return [varList, commaList]
    }

    function blockbody(terminator, ) {
        let body = block()
        let after = peek()
        if (after.Type == "Keyword" && after.Source == terminator) {
            get()
            return [body, after]
        } else {
            print(after.Type, after.Source)
            throw `${getTokenStartPosition(after)}: ${terminator} expected.`
        }
    }

    function funcdecl(isAnonymous, local) {
        let functionKw = get()

        let nameChain
        let nameChainSeperator

        if (!isAnonymous) {
            nameChain = []
            nameChainSeperator = []

            let token = expect("Ident")
            nameChain.push(token)

            while (peek().Source == ".") { 
                nameChainSeperator.push(get())
                nameChain.push(expect("Ident"))
            }

            if (peek().Source == ":") {
                nameChainSeperator.push(get())
                nameChain.push(expect("Ident"))
            }
        }

        let oparenTk = expect("Symbol", "(")

        let [argList, argCommaList, vargToken] = varlist(true)
        let cparenTk = expect("Symbol", ")")
        let [fbody, enTk] = blockbody("end", )

        let node
        node = MkNode({
            "Type": (isAnonymous == true ? "FunctionLiteral" : "FunctionStat"),
            "NameChain": nameChain,
            "ArgList": argList,
            "Body": fbody,

            "Token_Function": functionKw,
            "Token_NameChainSeperator": nameChainSeperator,
            "Token_OpenParen": oparenTk,
            "Token_Varg": vargToken,
            "Token_ArgCommaList": argCommaList,
            "Token_CloseParen": cparenTk,
            "Token_End": enTk,
            "GetFirstToken": () => node.Token_Function,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function functionargs() {
        let tk = peek()
        if (tk.Source == "(") {
            let oparenTk = get()
            let argList = []
            let argCommaList = []
            while (peek().Source != ")") {
                argList.push(expr())
                if (peek().Source == ",") {
                    argCommaList.push(get())
                } else {
                    break
                }
            }

            let cparenTk = expect("Symbol", ")")
            let node
            node = MkNode({
                "CallType": "ArgCall",
                "ArgList": argList,

                "Token_CommaList": argCommaList,
                "Token_OpenParen": oparenTk,
                "Token_CloseParen": cparenTk,
                "GetFirstToken": () => node.Token_OpenParen,
                "GetLastToken": () => node.Token_CloseParen,
            })
            return node
        } else if(tk.Source == "{") {
            let node
            node = MkNode({
                "CallType": "TableCall",
                "TableExpr": expr(),
                "GetFirstToken": () => node.TableExpr.GetFirstToken(),
                "GetLastToken": () => node.TableExpr.GetLastToken(),
            })
            return node
        } else if(tk.Type == "String") {
            let node
            node = MkNode({
                "CallType": "StringCall",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else {
            throw "Function arguments expected."
        }
    }


    function primaryexpr() {
        let base = prefixexpr()
        assert(base, "nil prefixexpr")

        while (true) {
            let tk = peek()

            if (tk.Source == ".") {
                let dotTk = get()
                let fieldName = expect("Ident")
                let node
                node = MkNode({
                    "Type": "FieldExpr",
                    "Base": base,
                    "Field": fieldName,
                    "Token_Dot": dotTk,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Field,
                })
                base = node
            } else if(tk.Source == ":") {
                let colonTk = get()
                let methodName = expect("Ident")
                let fargs = functionargs()
                let node
                node = MkNode({
                    "Type": "MethodExpr",
                    "Base": base,
                    "Method": methodName,
                    "FunctionArguments": fargs,
                    "Token_Colon": colonTk,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.FunctionArguments.GetLastToken(),
                })
                base = node
            } else if(tk.Source == "[") {
                let obrac = get()
                let index = expr()
                let cbrac = expect("Symbol", "]")
                let node
                node = MkNode({
                    "Type": "IndexExpr",
                    "Base": base,
                    "Index": index,
                    "Token_OpenBracket": obrac,
                    "Token_CloseBracket": cbrac,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Token_CloseBracket,
                })
                base = node
            } else if(tk.Source == "{" || tk.Source == "(" || tk.Type == "String") {
                let node
                node = MkNode({
                    "Type": "CallExpr",
                    "Base": base,
                    "FunctionArguments": functionargs(),
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.FunctionArguments.GetLastToken(),
                })
                base = node
            } else if(Compounds.includes(tk.Source)) {
                let compoundTk = get()
                let rhsExpr = expr()

                let node
                node = MkNode({
                    "Type": "CompoundStat",
                    "Base": base,
                    "Token_Compound": compoundTk,
                    "Rhs": rhsExpr,
                    "Lhs": base,
                    "GetFirstToken": () => node.Base.GetFirstToken(),
                    "GetLastToken": () => node.Rhs.GetLastToken(),
                })
                base = node
            } else {
                return base
            }
        }
    }

    function simpleexpr() {
        let tk = peek()
        if (tk.Type == "Number") {
            let node
            node = MkNode({
                "Type": "NumberLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token
            })

            return node
        } else if(tk.Type == "String") {
            let node
            node = MkNode({
                "Type": "StringLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "nil") {
            let node
            node = MkNode({
                "Type": "NilLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "true" || tk.Source == "false") {
            let node
            node = MkNode({
                "Type": "BooleanLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "...") {
            let node
            node = MkNode({
                "Type": "VargLiteral",
                "Token": get(),
                "GetFirstToken": () => node.Token,
                "GetLastToken": () => node.Token,
            })
            return node
        } else if(tk.Source == "{") {
            return tableexpr()
        } else if(tk.Source == "function") {
            return funcdecl(true, )
        } else {
            return primaryexpr()
        }
    }

    function subexpr(limit, ) {
        let curNode
        if (isUnop()) {
            let opTk = get()
            let ex = subexpr(UnaryPriority, )
            let node
            node = MkNode({
                "Type": "UnopExpr",
                "Token_Op": opTk,
                "Rhs": ex,
                "GetFirstToken": () => node.Token_Op,
                "GetLastToken": () => node.Rhs.GetLastToken(),
            })
            curNode = node
        } else {
            curNode = simpleexpr()
            assert(curNode, "nil sipleexpr")
        }  
    
        while (isBinop() && BinaryPriority[peek().Source] != undefined && BinaryPriority[peek().Source][0] > limit) {
            let opTk = get()
            let rhs = subexpr(BinaryPriority[opTk.Source][1], )
            assert(rhs, "RhsNeeded")
            let node
            node = MkNode({
                "Type": "BinopExpr",
                "Lhs": curNode,
                "Rhs": rhs,
                "Token_Op": opTk,
                "GetFirstToken": () => node.Lhs.GetFirstToken(),
                "GetLastToken": () => node.Rhs.GetLastToken(),
            })
            curNode = node
        }
        return curNode
    }

    expr = () => subexpr(0, )

    function exprstat() {
        let ex = primaryexpr()

        if (ex.Type == "MethodExpr" || ex.Type == "CallExpr") {
            let node
            node = MkNode({
                "Type": "CallExprStat",
                "Expression": ex,
                "GetFirstToken": () => node.Expression.GetFirstToken(),
                "GetLastToken": () => node.Expression.GetLastToken(),
            })
            return node
        } else if(ex.Type == "CompoundStat") {
            return ex
        } else {
            let lhs = [ex]
            let lhsSeperator = []
            while (peek().Source == ",") {
                lhsSeperator.push(get())
                let lhsPart = primaryexpr()
                if (lhsPart.Type == "MethodExpr" || lhsPart.Type == "CallExpr") {
                    throw "Bad left hand side of asignment"
                }
                lhs.push(lhsPart)
            }
            let eq = expect("Symbol", "=")
            let rhs = [expr()]
            let rhsSeperator = []
            while (peek().Source == ",") {
                rhsSeperator.push(get())
                rhs.push(expr())
            }

            let node
            node = MkNode({
                "Type": "AssignmentStat",
                "Rhs": rhs,
                "Lhs": lhs,
                "Token_Equals": eq,
                "Token_LhsSeperatorList": lhsSeperator,
                "Token_RhsSeperatorList": rhsSeperator,
                "GetFirstToken": () => node.Lhs[0].GetFirstToken(),
                "GetLastToken": () => node.Rhs[node.Rhs.length - 1].GetLastToken(),
            })

            return node
        }
    }

    function ifstat() {
        let ifKw = get()
        let condition = expr()
        let thenKw = expect("Keyword", "then")
        let ifBody = block()
        let elseClauses = []
        while (peek().Source == "elseif" || peek().Source == "else") {
            let elseifKw = get()
            let elseifCondition
            let elseifThenKw
            if (elseifKw.Source == "elseif") {
                elseifCondition = expr()
                elseifThenKw = expect("Keyword", "then")
            }
            let elseifBody = block()
            elseClauses.push({
                "Condition": elseifCondition,
                "Body": elseifBody,

                "ClauseType": elseifKw.Source,
                "Token": elseifKw,
                "Token_Then": elseifThenKw,
            })
            if (elseifKw.Source == "else") {
                break
            }
        }
        let enKw = expect("Keyword", "end")
        let node
        node = MkNode({
            "Type": "IfStat",
            "Condition": condition,
            "Body": ifBody,
            "ElseClauseList": elseClauses,
            
            "Token_If": ifKw,
            "Token_Then": thenKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_If,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }


    function dostat() {
        let doKw = get()
        let [body, enKw] = blockbody("end", )
        
        let node
        node = MkNode({
            "Type": "DoStat",
            "Body": body,
            
            "Token_Do": doKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_Do,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function whilestat() {
        let whileKw = get()
        let condition = expr()
        let doKw = expect("Keyword", "do")
        let [body, enKw] = blockbody("end", )

        let node
        node = MkNode({
            "Type": "WhileStat",
            "Condition": condition,
            "Body": body,
            
            "Token_While": whileKw,
            "Token_Do": doKw,
            "Token_End": enKw,
            "GetFirstToken": () => node.Token_While,
            "GetLastToken": () => node.Token_End,
        })
        return node
    }

    function forstat() {
        let forKw = get()
        let [loopVars, loopVarCommas] = varlist()
        let node = []
        if (peek().Source == "=") {
            let eqTk = get()
            let [exprList, exprCommaList] = exprlist()
            if (exprList.length < 2 || exprList.length > 3) {
                throw "Expected 2 or 3 values for range bounds"
            }
            let doTk = expect("Keyword", "do")
            let [body, enTk] = blockbody("end", )
            let node
            node = MkNode({
                "Type": "NumericForStat",
                "VarList": loopVars,
                "RangeList": exprList,
                "Body": body,
                
                "Token_For": forKw,
                "Token_VarCommaList": loopVarCommas,
                "Token_Equals": eqTk,
                "Token_RangeCommaList": exprCommaList,
                "Token_Do": doTk,
                "Token_End": enTk,
                "GetFirstToken": () => node.Token_For,
                "GetLastToken": () => node.Token_End,
            })
            return node
        } else if(peek().Source == "in") {
            let inTk = get()
            let [exprList, exprCommaList] = exprlist()
            let doTk = expect("Keyword", "do")
            let [body, enTk] = blockbody("end", )
            let node
            node = MkNode({
                "Type": "GenericForStat",
                "VarList": loopVars,
                "GeneratorList": exprList,
                "Body": body,

                "Token_For": forKw,
                "Token_VarCommaList": loopVarCommas,
                "Token_In": inTk,
                "Token_GeneratorCommaList": exprCommaList,
                "Token_Do": doTk,
                "Token_End": enTk,
                "GetFirstToken": () => node.Token_For,
                "GetLastToken": () => node.Token_End
            })
            return node
        }
    }

    function repeatstat() {
        let repeatKw = get()
        let [body, untilTk] = blockbody("until", locals)
        let condition = expr()

        let node
        node = MkNode({
            "Type": "RepeatStat",
            "Body": body,
            "Condition": condition,

            "Token_Repeat": repeatKw,
            "Token_Until": untilTk,
            "GetFirstToken": () => node.Token_Repeat,
            "GetLastToken": () => node.Condition.GetLastToken(),
        })
        return node
    }

    function localdecl() {
        let localKw = get()
        if (peek().Source == "function") {
            let funcStat = funcdecl(false, true)
            if (funcStat.NameChain.length > 1) {
                throw getTokenStartPosition(funcStat.Token_NameChainSeperator[0]) + ": `(` expected."
            }

            let node
            node = MkNode({
                "Type": "LocalFunctionStat",
                "FunctionStat": funcStat,
                "Token_Local": localKw,
                "GetFirstToken": () => node.Token_Local,
                "GetLastToken": () => node.FunctionStat.GetLastToken(),
            })
            return node
        } else if(peek().Type == "Ident") {
            let [varList, varCommaList] = varlist(false)
            let exprList = []
            let exprCommaList = []
            let eqToken
            if (peek().Source == "=") {
                eqToken = get()
                let [exprList1, exprCommaList1] = exprlist()
                exprList = exprList1
                exprCommaList = exprCommaList1
            }
            

            let node
            node = MkNode({
                "Type": "LocalVarStat",
                "VarList": varList,
                "ExprList": exprList,
                "Token_Local": localKw,
                "Token_Equals": eqToken,
                "Token_VarCommaList": varCommaList,
                "Token_ExprCommaList": exprCommaList,
                "GetFirstToken": () => node.Token_Local,
                "GetLastToken": function() {
                    if (node.ExprList.length > 0) {
                        return node.ExprList[node.ExprList.length - 1].GetLastToken()
                    } else {
                        return node.VarList[node.VarList.length - 1]
                    }
                },
            })
            return node
        } else {
            throw "`function` or ident expected"
        }
    }

    function retstat() {
        let returnKw = get()
        let exprList
        let commaList
        if (isBlockFollow() || peek().Source == ";") {
            exprList = []
            commaList = []
        } else {
            [exprList, commaList] = exprlist()
        }
        let self
        self = {
            "Type": "ReturnStat",
            "ExprList": exprList,
            "Token_Return": returnKw,
            "Token_CommaList": commaList,
            "GetFirstToken": () => self.Token_Return,
            "GetLastToken": function() {
                if (self.ExprList.length > 0) {
                    return self.ExprList[self.ExprList.length- 1].GetLastToken()
                } else {
                    return self.Token_Return
                }
            },
        }
        return self
    }

    function breakstat() {
        let breakKw = get()
        let self
        self = {
            "Type": "BreakStat",
            "Token_Break": breakKw,
            "GetFirstToken": () => self.Token_Break,
            "GetLastToken": () => self.Token_Break,
        }
        return self
    }

    function continuestat() {
        let continueKw = get()
        let self
        self = {
            "Type": "ContinueStat",
            "Token_Continue": continueKw,
            "GetFirstToken": () => self.Token_Continue,
            "GetLastToken": () => self.Token_Continue,
        }
        return self
    }

    function statement() {
        let tok = peek()
        if (tok.Source == "if") {
            return [false, ifstat()]
        } else if(tok.Source == "while") {
            return [false, whilestat()]
        } else if(tok.Source == "do") {
            return [false, dostat()]
        } else if(tok.Source == "for") {
            return [false, forstat()]
        } else if(tok.Source == "repeat") {
            return [false, repeatstat()]
        } else if(tok.Source == "function") {
            return [false, funcdecl(false, )]
        } else if(tok.Source == "local") {
            return [false, localdecl()]
        } else if(tok.Source == "return") {
            return [true, retstat()]
        } else if(tok.Source == "break") {
            return [true, breakstat()]
        } else if(tok.Source == "continue") {
            return [true, continuestat()]
        } else {
            return [false, exprstat()]
        }
    }


    let blocks = 1
    block = function(a, b) {
        let myblocknum = blocks++
        let statements = []
        let semicolons = []
        let isLast = false

        let locals = {}
        let upvals = {}
        if (b != null) {
            for (let [i, v] of Object.entries(b)) {
                upvals[i] = v
            }
        }

        if (a != null) {
            for (let [i, v] of Object.entries(a)) {
                upvals[i] = v
            }
        }


        let thing
        let i = 0
        while (!isLast && !isBlockFollow()) {
            if (thing && thing == peek()) {
                print(`INFINITE LOOP POSSIBLE ON STATEMENT ${thing.Source} :`,thing)
            }
            thing = peek()
            let [isL, stat] = statement()
            isLast = isL
            if (stat) {
                statements.push(stat);


                switch (stat.Type) {
                    case "LocalVarStat":
                        stat.VarList.forEach(token => {

                            token.UseCount = 0
                            token.Number = i++
                            locals[token.Source] = token

                            let tokens = []
                            function lol() {
                                token.UseCount++
                                tokens.forEach(t => {
                                    t.UseCount = token.UseCount
                                })
                            }

                            token.Tokens = {}
                            token.Tokens.push = (t) => {
                                t.UseCountIncrease = lol
                                t.UseCount = token.UseCount
                                t.Tokens = token.Tokens
                                tokens.push(t)
                            }
                            token.Tokens.get = () => tokens

                            token.UseCountIncrease = lol
                        })
                        break

                    case "LocalFunctionStat":

                        let nameChain = stat.FunctionStat.NameChain
                        if (nameChain.length === 1) {
                            let token = nameChain[0]
                            token.UseCount = 0
                            token.Number = i++
                            locals[token.Source] = token

                            let tokens = []
                            function lol() {
                                token.UseCount++
                                tokens.forEach(t => {
                                    t.UseCount = token.UseCount
                                })
                            }

                            token.Tokens = {}
                            token.Tokens.push = (t) => {
                                t.UseCountIncrease = lol
                                t.UseCount = token.UseCount
                                t.Tokens = token.Tokens
                                tokens.push(t)
                            }
                            token.Tokens.get = () => tokens

                            token.UseCountIncrease = lol
                        }
                        break

                    default:
                        break
                }
            }

            let next = peek()
            if (next.Type == "Symbol" && next.Source == ";") {
                semicolons[statements.length - 1] = get()
            }
        }

        let node
        node = {
            "Type": "StatList",
            "StatementList": statements,
            "SemicolonList": semicolons,
            "GetFirstToken": function() {
                if (node.StatementList.length == 0) {
                    return
                } else {
                    return node.StatementList[0].GetFirstToken()
                }
            },
            "GetLastToken": function() {
                if (node.StatementList.length == 0) {
                    return
                } else if(node.SemicolonList[node.StatementList.length - 1]) {
                    return node.SemicolonList[node.StatementList.length - 1]
                } else {
                    return node.StatementList[node.StatementList.length - 1].GetLastToken()
                }
            },
        }
        return node
    }

    print("Parsing block")
    return block()
}

function VisitAst(ast, visitors) {
    let ExprType = {
		'BinopExpr': true, 'UnopExpr': true, 
		'NumberLiteral': true, 'StringLiteral': true, 'NilLiteral': true, 'BooleanLiteral': true, 'VargLiteral': true,
		'FieldExpr': true, 'IndexExpr': true,
		'MethodExpr': true, 'CallExpr': true,
		'FunctionLiteral': true,
		'VariableExpr': true,
		'ParenExpr': true,
		'TableLiteral': true,
    }

    let StatType = {
		'StatList': true,
		'BreakStat': true,
        'ContinueStat': true,
		'ReturnStat': true,
		'LocalVarStat': true,
		'LocalFunctionStat': true,
		'FunctionStat': true,
		'RepeatStat': true,
		'GenericForStat': true,
		'NumericForStat': true,
		'WhileStat': true,
		'DoStat': true,
		'IfStat': true,
		'CallExprStat': true,
		'AssignmentStat': true,
        'CompoundStat': true
    }

    for (var [visitorSubject, visitor] of Object.entries(visitors)) {
        if (!StatType[visitorSubject] && !ExprType[visitorSubject]) {
            throw `Invalid visitor target: \`${visitorSubject}\``
        }
    }


    function preVisit(exprOrStat) {
        if (exprOrStat != null) {
            let visitor = visitors[exprOrStat.Type]
            if (typeof(visitor) == "function") {
                return visitor(exprOrStat)
            } else if(visitor && visitor.Pre) {
                return visitor.Pre(exprOrStat)
            }
        }
    }

    function postVisit(exprOrStat) {
        let visitor = visitors[exprOrStat.Type]
        if (visitor && typeof(visitor) == "object" && visitor.Post) {
            return visitor.Post(exprOrStat)
        }
    }

    let visitExpr
    let visitStat

    visitExpr = function(expr) {
        if (preVisit(expr)) {
            return
        }

        if (expr.Type == "BinopExpr") {
            visitExpr(expr.Lhs)
            visitExpr(expr.Rhs)
        } else if(expr.Type == "UnopExpr") {
            visitExpr(expr.Rhs)
        } else if(expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral") 
        {
            //No
        } else if(expr.Type == "FieldExpr") {
            visitExpr(expr.Base)
        } else if(expr.Type == "IndexExpr") {
            visitExpr(expr.Base)
            visitExpr(expr.Index)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            visitExpr(expr.Base)
            if (expr.FunctionArguments.CallType == "ArgCall") {
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    visitExpr(argExpr)
                })
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                visitExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            visitStat(expr.Body)
        } else if(expr.Type == "VariableExpr") {
            // no
        } else if(expr.Type == "ParenExpr") {
            visitExpr(expr.Expression)

        } else if(expr.Type == "TableLiteral") {
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    visitExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    visitExpr(entry.Index)
                    visitExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    visitExpr(entry.Value)
                } else {
                    throw "unreachable"
                }
            })
        } else if(expr.Type == "CompoundStat") {
            visitExpr(expr.Lhs)
            visitExpr(expr.Rhs)
        } else {
            throw `unreachable, type: ${expr.Type}: ${expr}`
        }
        postVisit(expr)
    }

    visitStat = function(stat) {
        if (preVisit(stat)) {
            return
        }

        if (stat.Type == "StatList") {
            stat.StatementList.forEach((ch, index) => {
                if (ch != null) {
                    if (ch === null || ch.Type === null) {
                        return
                    }
    
                    ch.Remove = () => {
                        stat.StatementList[index] = null
                    }

                    visitStat(ch)
                }
            })
        } else if(stat.Type == "BreakStat") {
            // no
        } else if(stat.Type == "ContinueStat") {
            // fuck off
        } else if(stat.Type == "ReturnStat") {
            stat.ExprList.forEach((expr, index) => {
                visitExpr(expr)
            })
        } else if(stat.Type == "LocalVarStat") {
            if (stat.Token_Equals) {
                stat.ExprList.forEach((expr, index) => {
                    visitExpr(expr)
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            visitStat(stat.FunctionStat.Body)
        } else if(stat.Type == "FunctionStat") {
            visitStat(stat.Body)
        } else if(stat.Type == "RepeatStat") {
            visitStat(stat.Body)
            visitExpr(stat.Condition)
        } else if(stat.Type == "GenericForStat") {
            stat.GeneratorList.forEach((expr, index) => {
                visitExpr(expr)
            })
            visitStat(stat.Body)
        } else if(stat.Type == "NumericForStat") {
            stat.RangeList.forEach((expr, index) => {
                visitExpr(expr)
            })
            visitStat(stat.Body)
        } else if(stat.Type == "WhileStat") {
            visitExpr(stat.Condition)
            visitStat(stat.Body)
        } else if(stat.Type == "DoStat") {
            visitStat(stat.Body)
        } else if(stat.Type == "IfStat") {
            visitExpr(stat.Condition)
            visitStat(stat.Body)
            stat.ElseClauseList.forEach((clause) => {
                if (clause.Condition != null) {
                    visitExpr(clause.Condition)
                }
                visitStat(clause.Body)
            })
        } else if(stat.Type == "CallExprStat") {
            visitExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") {
            visitExpr(stat.Rhs)
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex) => {
                visitExpr(ex)
            })
            stat.Rhs.forEach((ex) => {
                visitExpr(ex)
            })
        } else {
            throw "unreachable"
        }
        postVisit(stat)
    }
    
    if (StatType[ast.Type]) {
        visitStat(ast)
    } else {
        visitExpr(ast)
    }
}

function AddVariableInfo(ast) {
    let globalVars = []
    let currentScope

    let locationGenerator = 0
    function markLocation() {
        locationGenerator++
        return locationGenerator
    }

    function pushScope() {
        currentScope = {
            "ParentScope": currentScope,
            "ChildScopeList": [],
            "VariableList": [],
            "BeginLocation": markLocation(),
        }
        if (currentScope.ParentScope) {
            currentScope.Depth = currentScope.ParentScope.Depth + 1
            currentScope.ParentScope.ChildScopeList.push(currentScope)
        } else {
            currentScope.Depth = 1
        }
        let self = currentScope
        currentScope.GetVar = function(varName){
            self.VariableList.forEach((_var) => {
                if (_var.Name == varName) {
                    return _var
                }
            })
            if (self.ParentScope) {
                return self.ParentScope.GetVar(varName)
            } else {
                globalVars.forEach((_var) => {
                    if (_var.Name == varName) {
                        return _var
                    }
                })
            }
        }
    }

    function popScope() {
        let scope = currentScope

        scope.EndLocation = markLocation()

        scope.VariableList.forEach((v) => {
            v.ScopeEndLocation = scope.EndLocation
        })

        currentScope = scope.ParentScope
        return scope
    }
    pushScope()

    function addLocalVar(name, setNameFunc, localInfo) {
        assert(localInfo, "MIssing localInfo")
        assert(name, "Missing local var name")
        let _var = {
            "Type": "Local",
            "Name": name,
            "RenameList": [setNameFunc],
            "AssignedTo": false,
            "Info": localInfo,
            "Scope": currentScope,
            "BeginLocation": markLocation(),
            "EndLocation": markLocation(),
            "ReferenceLocationList": [markLocation()],
        }
        _var.Rename = function(newName) {
            _var.Name = newName
            _var.RenameList.forEach((renameFunc) => {
                renameFunc(newName)
            })
        }

        currentScope.VariableList.push(_var)
        return _var
    }

    function getGlobalVar(name) {
        globalVars.forEach((_var) => {
            if (_var.Name == name) {
                return _var
            }
        })

        let _var = {
            "Type": "Global",
            "Name": name,
            "RenameList": [],
            "AssignedTo": false,
            "Scope": null,
            "BeginLocation": markLocation(),
            "EndLocation": markLocation(),
            "ReferenceLocationList": [],
        }

        _var.Rename = function(newName) {
            _var.Name = newName
            _var.RenameList.forEach((renameFunc) => {
                renameFunc(newName)
            })
        }
        
        globalVars.push(_var)

        return _var
    }


    function addGlobalReference(name, setNameFunc) {
        assert(name, "Missing var name")
        let _var = getGlobalVar(name)
        _var.RenameList.push(setNameFunc)
        return _var
    }

    function getLocalVar(scope, name) {
        let i
        for (i=scope.VariableList.length-1; i>=0; i--) {
            if (scope.VariableList[i].Name == name) {
                return scope.VariableList[i]
            }
        }

        if (scope.ParentScope) {
            let _var = getLocalVar(scope.ParentScope, name)
            if (_var) {
                return _var
            }
        }

        return
    }

    function referenceVariable(name, setNameFunc) {
        assert(name, "Missing var name")
        let _var = getLocalVar(currentScope, name)
        if (_var) {
            _var.RenameList.push(setNameFunc)
        } else {
            _var = addGlobalReference(name, setNameFunc)
        }

        let curLocation = markLocation()
        _var.EndLocation = curLocation
        _var.ReferenceLocationList.push(_var.EndLocation)
        return _var
    }

    let visitor = {}
    visitor.FunctionLiteral = {

        "Pre": function(expr) {
            pushScope()
            expr.ArgList.forEach((ident, index) => {
                let _var = addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function(expr) {
            popScope()
        },
    }

    visitor.VariableExpr = function(expr) {
        expr.Variable = referenceVariable(expr.Token.Source, function(newName) {
            expr.Token.Source = newName
        })
    }

    visitor.StatList = {
        "Pre": function(stat) {
            pushScope()
        },

        "Post": function(stat) {
            if (!stat.SkipPop) {
                popScope()
            }
        },
    }

    visitor.LocalVarStat = {
        "Post": function(stat) {
    
            stat.VarList.forEach((ident, varNum) => {
                addLocalVar(ident.Source, function(name) {
                    stat.VarList[varNum].Source = name
                }, {
                    "Type": "Local",
                })
            })
        },
    }

    visitor.LocalFunctionStat = {
        "Pre": function(stat) {
            addLocalVar(stat.FunctionStat.NameChain[0].Source, function(name) {
                stat.FunctionStat.NameChain[0].Source = name
            }, {
                "Type": "LocalFunction",
            })

            pushScope()

            stat.FunctionStat.ArgList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function() {
            popScope()
        }
    }

    visitor.FunctionStat = {
        "Pre": function(stat) {
            let nameChain = stat.NameChain
            let _var
            if (nameChain.length == 1) {
                if (getLocalVar(currentScope, nameChain[0].Source)) {
                    _var = referenceVariable(nameChain[0].Source, function(name) {
                        nameChain[0].Source = name
                    })
                } else {
                    _var = addGlobalReference(nameChain[0].Source, function(name) {
                        nameChain[0].Source = name
                    })
                }
            } else {
                _var = referenceVariable(nameChain[0].Source, function(name) {
                    nameChain[0].Source = name
                })
            }
            _var.AssignedTo = true
            pushScope()
            stat.ArgList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "Argument",
                    "Index": index,
                })
            })
        },

        "Post": function() {
            popScope()
        }
    }

    visitor.GenericForStat = {
        "Pre": function(stat) {

            stat.GeneratorList.forEach((ex) => {
                VisitAst(ex, visitor)
            })

            pushScope()
            stat.VarList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "ForRange",
                    "Index": index,
                })
            })
            VisitAst(stat.Body, visitor)
            popScope()
            return true
        }
    }

    visitor.NumericForStat = {
        "Pre": function(stat) {
            stat.RangeList.forEach((ex) => {
                VisitAst(ex, visitor)
            })

            pushScope()
            stat.VarList.forEach((ident, index) => {
                addLocalVar(ident.Source, function(name) {
                    ident.Source = name
                }, {
                    "Type": "ForRange",
                    "Index": index,
                })
            })
            VisitAst(stat.Body, visitor)
            popScope()
            return true
        }
    }

    visitor.RepeatStat = {
        "Pre": function(stat) {
            stat.Body.SkipPop = true
        },
        "Post": function(stat) {
            popScope()
        }
    }
    visitor.AssignmentStat = {
        "Post": function(stat) {
            stat.Lhs.forEach((ex) => {
                if (ex.Variable != null) {
                    ex.Variable.AssignedTo = true
                }
            })
        }
    }
    VisitAst(ast, visitor)
    return [globalVars, popScope()]
}

function PrintAst(ast) {
    let printStat
    let printExpr
    let buffer = ''
    function printt(tk) {
        if (tk.Source == null) {
            throw `Bad token: tk=${tk} | source=${tk.Source}`
        }
        buffer += `${(typeof tk.LeadingWhite !== 'string' ? ' ' : tk.LeadingWhite)}${tk.Source}`
    }

    printExpr = function(expr) {
        if (expr.Type == "BinopExpr") {
            printExpr(expr.Lhs)
            printt(expr.Token_Op)
            printExpr(expr.Rhs)
        } else if(expr.Type == "UnopExpr") {
            printt(expr.Token_Op)
            printExpr(expr.Rhs)
        } else if(
                expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral") 
        {
            printt(expr.Token)
        } else if(expr.Type == "FieldExpr") {
            printExpr(expr.Base)
            printt(expr.Token_Dot)
            printt(expr.Field)
        } else if(expr.Type == "IndexExpr") {
            printExpr(expr.Base)
            printt(expr.Token_OpenBracket)
            printExpr(expr.Index)
            printt(expr.Token_CloseBracket)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            printExpr(expr.Base)
            if (expr.Type == "MethodExpr") {
                printt(expr.Token_Colon)
                printt(expr.Method)
            }
            if (expr.FunctionArguments.CallType == "StringCall") {
                printt(expr.FunctionArguments.Token)
            } else if(expr.FunctionArguments.CallType == "ArgCall") {
                printt(expr.FunctionArguments.Token_OpenParen)
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    printExpr(argExpr)
                    let sep = expr.FunctionArguments.Token_CommaList[index]
                     if (sep != null) {
                        printt(sep)
                    }
                })
                printt(expr.FunctionArguments.Token_CloseParen)
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                printExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            printt(expr.Token_Function)
            printt(expr.Token_OpenParen)
            expr.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = expr.Token_ArgCommaList[index]
                if (comma != null) {
                    printt(comma)
                }
            })
            if (expr.Token_Varg != null) {
                printt(expr.Token_Varg)
            }
            printt(expr.Token_CloseParen)
            printStat(expr.Body)
            printt(expr.Token_End)
        } else if(expr.Type == "VariableExpr") {
            printt(expr.Token)
        } else if(expr.Type == "ParenExpr") {
            printt(expr.Token_OpenParen)
            printExpr(expr.Expression)
            printt(expr.Token_CloseParen)
        } else if(expr.Type == "TableLiteral") {
            printt(expr.Token_OpenBrace)
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    printt(entry.Field)
                    printt(entry.Token_Equals)
                    printExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    printt(entry.Token_OpenBracket)
                    printExpr(entry.Index)
                    printt(entry.Token_CloseBracket)
                    printt(entry.Token_Equals)
                    printExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    printExpr(entry.Value)
                } else {
                    throw "unreachable"
                }
                let sep = expr.Token_SeperatorList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(expr.Token_CloseBrace)
        } else if(expr.Type == "CompoundStat") {
            printStat(expr)
        } else {
            throw `unreachable, type: ${expr.Type}: ${expr}`
        }
    }
    printStat = function(stat) {
        if (stat == null) {
            throw `STAT IS NIL! ${stat}`
        }

        if (stat.Type == "StatList") {
            stat.StatementList.forEach((ch, index) => {
                if (ch === null || ch.Type === null) {
                    return
                }

                ch.Remove = () => {
                    stat.StatementList[index] = null
                }

                printStat(ch)
                if (stat.SemicolonList[index]) {
                    printt(stat.SemicolonList[index])
                }
            })

        } else if(stat.Type == "BreakStat") {
            printt(stat.Token_Break)
        } else if(stat.Type == "ContinueStat") {
            printt(stat.Token_Continue)
        } else if(stat.Type == "ReturnStat") {
            printt(stat.Token_Return)
            stat.ExprList.forEach((expr, index) => {
                printExpr(expr)
                if (stat.Token_CommaList[index]) {
                    printt(stat.Token_CommaList[index])
                }
            })
        } else if(stat.Type == "LocalVarStat") {
            printt(stat.Token_Local)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let comma = stat.Token_VarCommaList[index]
                if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.Token_Equals != null) {
                printt(stat.Token_Equals)
                stat.ExprList.forEach((expr, index) => {
                    printExpr(expr)
                    let comma = stat.Token_ExprCommaList[index]
                     if (comma != null) {
                        printt(comma)
                    }
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            printt(stat.Token_Local)
            printt(stat.FunctionStat.Token_Function)
            printt(stat.FunctionStat.NameChain[0])
            printt(stat.FunctionStat.Token_OpenParen)
            stat.FunctionStat.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = stat.FunctionStat.Token_ArgCommaList[index]
                 if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.FunctionStat.Token_Varg) {
                printt(stat.FunctionStat.Token_Varg)
            }
            printt(stat.FunctionStat.Token_CloseParen)
            printStat(stat.FunctionStat.Body)
            printt(stat.FunctionStat.Token_End)
        } else if(stat.Type == "FunctionStat") {
            printt(stat.Token_Function)
            stat.NameChain.forEach((part, index) => {
                printt(part)
                let sep = stat.Token_NameChainSeperator[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_OpenParen)
            stat.ArgList.forEach((arg, index) => {
                printt(arg)
                let comma = stat.Token_ArgCommaList[index]
                 if (comma != null) {
                    printt(comma)
                }
            })
            if (stat.Token_Varg) {
                printt(stat.Token_Varg)
            }
            printt(stat.Token_CloseParen)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "RepeatStat") {
            printt(stat.Token_Repeat)
            printStat(stat.Body)
            printt(stat.Token_Until)
            printExpr(stat.Condition)
        } else if(stat.Type == "GenericForStat") {
            printt(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_In)
            stat.GeneratorList.forEach((expr, index) => {
                printExpr(expr)
                let sep = stat.Token_GeneratorCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "NumericForStat") {
            printt(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                printt(_var)
                let sep = stat.Token_VarCommaList[index]
                 if (sep != null) {
                    printt(sep);
                }
            })
            printt(stat.Token_Equals)
            stat.RangeList.forEach((expr, index) => {
                printExpr(expr)
                let sep = stat.Token_RangeCommaList[index]
                 if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "WhileStat") {
            printt(stat.Token_While)
            printExpr(stat.Condition)
            printt(stat.Token_Do)
            printStat(stat.Body)
            printt(stat.Token_End)
        } else if(stat.Type == "DoStat") {
            printt(stat.Token_Do)
            printStat(stat.Body)

            printt(stat.Token_End)
        } else if(stat.Type == "IfStat") {
            printt(stat.Token_If)
            printExpr(stat.Condition)
            printt(stat.Token_Then)
            printStat(stat.Body)
            stat.ElseClauseList.forEach((clause) => {
                printt(clause.Token)
                if (clause.Condition != null) {
                    printExpr(clause.Condition)
                    printt(clause.Token_Then)
                }
                printStat(clause.Body)
            })
            printt(stat.Token_End)
        } else if(stat.Type == "CallExprStat") {
            printExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") { // Fuck you Wally
            printExpr(stat.Lhs)
            printt(stat.Token_Compound)
            printExpr(stat.Rhs)
            stat.Type = "CompoundStat"
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex, index) => {
                printExpr(ex)
                let sep = stat.Token_LhsSeperatorList[index]
                if (sep != null) {
                    printt(sep)
                }
            })
            printt(stat.Token_Equals)
            stat.Rhs.forEach((ex, index) => {
                printExpr(ex)
                let sep = stat.Token_RhsSeperatorList[index]
                if (sep != null) {
                    printt(sep);
                }
            })
        } else {
            printExpr(stat)
        }
    }
    printStat(ast)
    
    return buffer
}

function shuffleArray(array) {
    var currentIndex = array.length,  randomIndex;
  
    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
  
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
  
      // And swap it with the current element.
      [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
  
    return array;
}

function StripAst(ast) {
    quotes = shuffleArray(quotes)
    let stripStat
    let stripExpr
    function stript(token) {
        token.LeadingWhite = ''
    }

    function joint(tokenA, tokenB, shit = false) {
        stript(tokenB)

        let lastCh = (typeof tokenA.Source == 'string' ? tokenA.Source : tokenA.Source.toString()).substr(tokenA.Source.length - 1,1)
        let firstCh = (typeof tokenB.Source == 'string' ? tokenB.Source : tokenB.Source.toString()).substr(0,1)
        
        if ((lastCh == "-" && firstCh == "-") || (AllIdentChars.includes(lastCh) && AllIdentChars.includes(firstCh)) || (shit && lastCh == ')' && firstCh == '(')) {
            tokenB.LeadingWhite = shit ? ';' : ' '
        } else {
            tokenB.LeadingWhite = ""
        }
    }

    function bodyjoint(open, body, close) {

        //stripStat(body) // This slow
        stript(close)
        let bodyFirst = body.GetFirstToken()
        let bodyLast = body.GetLastToken()

        if (bodyFirst != null) {
            joint(open, bodyFirst)
            joint(bodyLast, close)
        } else {
            joint(open, close)
        }
    }

    stripExpr = function(expr) {
        //print(expr.Type)
        if (expr.Type == "BinopExpr") {
            stripExpr(expr.Lhs)
            stript(expr.Token_Op)
            stripExpr(expr.Rhs)

            joint(expr.Token_Op, expr.Rhs.GetFirstToken())
            joint(expr.Lhs.GetLastToken(), expr.Token_Op)
        } else if(expr.Type == "UnopExpr") {
            stript(expr.Token_Op)
            stripExpr(expr.Rhs)

            joint(expr.Token_Op, expr.Rhs.GetFirstToken())
        } else if(expr.Type == "NumberLiteral" || expr.Type == "StringLiteral"
                || expr.Type == "NilLiteral" || expr.Type == "BooleanLiteral"
                || expr.Type == "VargLiteral")
        {
            if (expr.Type == 'NumberLiteral') {
                if (Math.random() > 0.5 && !(expr.Token.Source.search(/\./) > -1) && parseInt(expr.Token.Source) < 40 && parseInt(expr.Token.Source) > 0) {
                    let n = parseInt(expr.Token.Source)
                    let quot = quotes[quotes.length * Math.random() | 0]
                    expr.Type = 'StringLiteral'
                    expr.Token.Type = 'String'
                    if (Math.random() > .6)
                        expr.Token.Source = `((function(A) return (#A - ${quot.length - n}) end)('${quot}'))`
                    else
                        expr.Token.Source = `(#('${quot}') - ${quot.length - n})`
                    
                }
            }
            stript(expr.Token)
        } else if(expr.Type == "FieldExpr") {
            stripExpr(expr.Base)
            stript(expr.Token_Dot)
            stript(expr.Field)
        } else if(expr.Type == "IndexExpr") {
            stripExpr(expr.Base)
            stript(expr.Token_OpenBracket)
            stripExpr(expr.Index)
            stript(expr.Token_CloseBracket)
        } else if(expr.Type == "MethodExpr" || expr.Type == "CallExpr") {
            stripExpr(expr.Base)
            if (expr.Type == "MethodExpr") {
                stript(expr.Token_Colon)
                stript(expr.Method)
            }
            if (expr.FunctionArguments.CallType == "StringCall") {
                stript(expr.FunctionArguments.Token)
            } else if(expr.FunctionArguments.CallType == "ArgCall") {
                stript(expr.FunctionArguments.Token_OpenParen)
                expr.FunctionArguments.ArgList.forEach((argExpr, index) => {
                    stripExpr(argExpr)
                    let sep = expr.FunctionArguments.Token_CommaList[index]
                    if (sep != null) {
                        stript(sep)
                    }
                })
                stript(expr.FunctionArguments.Token_CloseParen)
            } else if(expr.FunctionArguments.CallType == "TableCall") {
                stripExpr(expr.FunctionArguments.TableExpr)
            }
        } else if(expr.Type == "FunctionLiteral") {
            stript(expr.Token_Function)
            stript(expr.Token_OpenParen)
            expr.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = expr.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (expr.Token_Varg != null) {
                stript(expr.Token_Varg)
            }
            stript(expr.Token_CloseParen)
            stripStat(expr.Body)
            bodyjoint(expr.Token_CloseParen, expr.Body, expr.Token_End)
        } else if(expr.Type == "VariableExpr") {
            stript(expr.Token)
        } else if(expr.Type == "ParenExpr") {
            stript(expr.Token_OpenParen)
            stripExpr(expr.Expression)
            stript(expr.Token_CloseParen)
        } else if(expr.Type == "TableLiteral") {
            stript(expr.Token_OpenBrace)
            expr.EntryList.forEach((entry, index) => {
                if (entry.EntryType == "Field") {
                    stript(entry.Field)
                    stript(entry.Token_Equals)
                    stripExpr(entry.Value)
                } else if(entry.EntryType == "Index") {
                    stript(entry.Token_OpenBracket)
                    stripExpr(entry.Index)
                    stript(entry.Token_CloseBracket)
                    stript(entry.Token_Equals)
                    stripExpr(entry.Value)
                } else if(entry.EntryType == "Value") {
                    stripExpr(entry.Value)
                } else {
                    assert(false, "unreachable")
                }
                let sep = expr.Token_SeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            
            expr.Token_SeperatorList[expr.EntryList.length-1] = null
            stript(expr.Token_CloseBrace)
        } else {
            throw(`unreachable, type: ${expr.Type}:${expr}  ${console.trace()}`)
        }
    }
    
    stripStat = function(stat) {
        if (stat.Type == "StatList") {
            let i
            for (i=0; i<=stat.StatementList.length;i++) {
                let chStat = stat.StatementList[i]
                if (chStat == null) continue;
                
                stripStat(chStat)
                stript(chStat.GetFirstToken())
                let lastChStat = stat.StatementList[i-1]
                if (lastChStat != null) {

                    if (stat.SemicolonList[i-1]
                        && lastChStat.GetLastToken().Source != ")" || chStat.GetFirstToken().Source != ")") 
                    {
                        stat.SemicolonList[i-1] = null
                    }

                    if (!stat.SemicolonList[i-1]) {
                        joint(lastChStat.GetLastToken(), chStat.GetFirstToken(), true)
                    }
                }
            }

            stat.SemicolonList[stat.StatementList.length-1] = null
            if (stat.StatementList.length > 0) {
                stript(stat.StatementList[0].GetFirstToken())
            }
        } else if(stat.Type == "BreakStat") {
            stript(stat.Token_Break)
        } else if(stat.Type == "ContinueStat") {
            stript(stat.Token_Continue)
        } else if(stat.Type == "ReturnStat") {
            stript(stat.Token_Return)
            stat.ExprList.forEach((expr, index) => {
                stripExpr(expr)
                if (stat.Token_CommaList[index] != null) {
                    stript(stat.Token_CommaList[index])
                }
            })
            if (stat.ExprList.length > 0) {
                joint(stat.Token_Return, stat.ExprList[0].GetFirstToken())
            }
        } else if(stat.Type == "LocalVarStat") {
            stript(stat.Token_Local)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_Local, _var)
                } else {
                    stript(_var)
                }
                let comma = stat.Token_VarCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (stat.Token_Equals != null) {
                stript(stat.Token_Equals)
                stat.ExprList.forEach((expr, index) => {
                    stripExpr(expr)
                    let comma = stat.Token_ExprCommaList[index]
                    if (comma != null) {
                        stript(comma)
                    }
                })
            }
        } else if(stat.Type == "LocalFunctionStat") {
            stript(stat.Token_Local)
            joint(stat.Token_Local, stat.FunctionStat.Token_Function)
            joint(stat.FunctionStat.Token_Function, stat.FunctionStat.NameChain[0])
            joint(stat.FunctionStat.NameChain[0], stat.FunctionStat.Token_OpenParen)

            stat.FunctionStat.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = stat.FunctionStat.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })
            if (stat.FunctionStat.Token_Varg) {
                stript(stat.FunctionStat.Token_Varg)
            }
            stript(stat.FunctionStat.Token_CloseParen)
            stripStat(stat.FunctionStat.Body)
            bodyjoint(stat.FunctionStat.Token_CloseParen, stat.FunctionStat.Body, stat.FunctionStat.Token_End)
        } else if(stat.Type == "FunctionStat") {
            stript(stat.Token_Function)
            stat.NameChain.forEach((part, index) => {
                if (index == 0) {
                    joint(stat.Token_Function, part)
                } else {
                    stript(part)
                }
                let sep = stat.Token_NameChainSeperator[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            stript(stat.Token_OpenParen)
            stat.ArgList.forEach((arg, index) => {
                stript(arg)
                let comma = stat.Token_ArgCommaList[index]
                if (comma != null) {
                    stript(comma)
                }
            })

            if (stat.Token_Varg) {
                stript(stat.Token_Varg)
            }
            stript(stat.Token_CloseParen)
            stripStat(stat.Body)
            bodyjoint(stat.Token_CloseParen, stat.Body, stat.Token_End)
        } else if(stat.Type == "RepeatStat") {
            stript(stat.Token_Repeat)
            stripStat(stat.Body)
            bodyjoint(stat.Token_Repeat, stat.Body, stat.Token_Until)
            stripExpr(stat.Condition)
            joint(stat.Token_Until, stat.Condition.GetFirstToken())
        } else if(stat.Type == "GenericForStat") {
            stript(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_For, _var)
                } else {
                    stript(_var)
                }
                let sep = stat.Token_VarCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.VarList[stat.VarList.length-1], stat.Token_In)
            stat.GeneratorList.forEach((expr, index) => {
                stripExpr(expr)
                if (index == 0) {
                    joint(stat.Token_In, expr.GetFirstToken())
                }
                let sep = stat.Token_GeneratorCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.GeneratorList[stat.GeneratorList.length-1].GetLastToken(), stat.Token_Do)
            stripStat(stat.Body)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "NumericForStat") {
            stript(stat.Token_For)
            stat.VarList.forEach((_var, index) => {
                if (index == 0) {
                    joint(stat.Token_For, _var)
                } else {
                    stript(_var)
                }
                let sep = stat.Token_VarCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.VarList[stat.VarList.length-1], stat.Token_Equals)
            stat.RangeList.forEach((expr, index) => {
                stripExpr(expr)
                if (index == 0) {
                    joint(stat.Token_Equals, expr.GetFirstToken())
                }
                let sep = stat.Token_RangeCommaList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            joint(stat.RangeList[stat.RangeList.length-1].GetLastToken(), stat.Token_Do)
            stripStat(stat.Body)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "WhileStat") {
            stript(stat.Token_While)
            stripExpr(stat.Condition)
            stript(stat.Token_Do)
            joint(stat.Token_While, stat.Condition.GetFirstToken())
            joint(stat.Condition.GetLastToken(), stat.Token_Do)
            stripStat(stat.Body)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "DoStat") {
            stript(stat.Token_Do)
            stript(stat.Token_End)
            stripStat(stat.Body)
            bodyjoint(stat.Token_Do, stat.Body, stat.Token_End)
        } else if(stat.Type == "IfStat") {
            stript(stat.Token_If)
            stripExpr(stat.Condition)
            joint(stat.Token_If, stat.Condition.GetFirstToken())
            joint(stat.Condition.GetLastToken(), stat.Token_Then)

            let lastBodyOpen = stat.Token_Then
            let lastBody = stat.Body

            stripStat(lastBody)
            stat.ElseClauseList.forEach((clause, i) => {
                //stripStat(lastBody)
                bodyjoint(lastBodyOpen, lastBody, clause.Token)
                lastBodyOpen = clause.Token

                if (clause.Condition != null) {
                    stripExpr(clause.Condition)
                    joint(clause.Token, clause.Condition.GetFirstToken())
                    joint(clause.Condition.GetLastToken(), clause.Token_Then)
                    lastBodyOpen = clause.Token_Then
                }

                stripStat(clause.Body)
                lastBody = clause.Body            
            })

            //stripStat(lastBody)
            bodyjoint(lastBodyOpen, lastBody, stat.Token_End)
        } else if(stat.Type == "CallExprStat") {
            stripExpr(stat.Expression)
        } else if(stat.Type == "CompoundStat") {
            stripExpr(stat.Lhs)
            stript(stat.Token_Compound)
            stripExpr(stat.Rhs)

            joint(stat.Lhs.GetLastToken(), stat.Token_Compound)
            joint(stat.Token_Compound, stat.Rhs.GetFirstToken())

            lastBody = stat.Body
        } else if(stat.Type == "AssignmentStat") {
            stat.Lhs.forEach((ex, index) => {
                stripExpr(ex)
                let sep = stat.Token_LhsSeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
            stript(stat.Token_Equals)
            stat.Rhs.forEach((ex, index) => {
                stripExpr(ex)
                let sep = stat.Token_RhsSeperatorList[index]
                if (sep != null) {
                    stript(sep)
                }
            })
        } else {
            return stripExpr(stat)
            //print(`unreachable, type: ${stat.Type}`,stat)
            //throw(`unreachable, type: ${stat.Type}:${stat}`)
        }
    }

    stripStat(ast)
}


let VarDigits = []

let i
for (i="a".charCodeAt(); i<="z".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
for (i="A".charCodeAt(); i<="Z".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
for (i="0".charCodeAt(); i<="9".charCodeAt(); i++) VarDigits.push(String.fromCharCode(i));
VarDigits.push("_")

let VarStartDigits = []
for (i="a".charCodeAt(); i<="z".charCodeAt(); i++) VarStartDigits.push(String.fromCharCode(i));
for (i="A".charCodeAt(); i<="Z".charCodeAt(); i++) VarStartDigits.push(String.fromCharCode(i));


function indexToVarName(index) {
    let id = ""
    let d = index % VarStartDigits.length
    index = (index - d) / VarStartDigits.length
    id = `${id}${VarStartDigits[d]}`
    while (index > 0) {
        let d = index % VarDigits.length
        index = (index - d) / VarDigits.length
        id = `${id}${VarDigits[d]}`
    }
    return id
}

function MinifyVariables_2(globalScope, rootScope, renameGlobals) {
    let globalUsedNames = []
    for (var [kw, _] of Object.entries(Keywords)) {
        globalUsedNames[kw] = true
    }

    let allVariables = []
    let allLocalVariables = []
    
    globalScope.forEach((_var) => {
        if (_var.AssignedTo && renameGlobals) {
            allVariables.push(_var)
        } else {
            globalUsedNames[_var.Name] = true
        }
    })

    function addFrom(scope) {
        scope.VariableList.forEach((_var) => {
            allVariables.push(_var)
            allLocalVariables.push(_var)
        })
        scope.ChildScopeList.forEach((childScope) => {
            addFrom(childScope)
        })
    }
    addFrom(rootScope)

    allVariables.forEach((_var) => {
        _var.UsedNameArray = []
    })

    allVariables.sort((a, b) => a - b)

    let nextValidNameIndex = 0
    let varNamesLazy = []

    function varIndexToValidName(i) {
        let name = varNamesLazy[i]
        if (name == null) {
            name = indexToVarName(nextValidNameIndex)
            nextValidNameIndex++
            while (globalUsedNames[name]) {
                name = indexToVarName(nextValidNameIndex)
                nextValidNameIndex++  
            }
            varNamesLazy[i] = name
        }
        
        return name
    }

    allVariables.forEach((_var, _) => {
        _var.Renamed = true
        
        let i = 0
        while (_var.UsedNameArray[i]) {
            i++
        }

        _var.Rename(varIndexToValidName(i))

        if (_var.Scope) {

            allVariables.forEach((otherVar) => {
                if (!otherVar.Renamed) {
                    if (!otherVar.Scope || otherVar.Scope.Depth < _var.Scope.Depth) {
                        otherVar.ReferenceLocationList.some((refAt) => {
                            if (refAt >= _var.BeginLocation && refAt <= _var.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }
                            return false
                        })
                    } else if(otherVar.Scope.Depth > _var.Scope.Depth) {
                        _var.ReferenceLocationList.some((refAt) => {
                            if (refAt >= otherVar.BeginLocation && refAt <= otherVar.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }
                            return false
                        })
                    } else {
                        if (_var.BeginLocation < otherVar.EndLocation && _var.EndLocation > otherVar.BeginLocation) {
                           otherVar.UsedNameArray[i] = true
                        }
                    }
                }
            })
        } else {
            allVariables.forEach((otherVar) => {
                if (!otherVar.Renamed) {
                    if (otherVar.Type == "Global") {
                        otherVar.UsedNameArray[i] = true
                    } else if(otherVar.Type == "Local") {

                        _var.ReferenceLocationList.some((refAt) => {
                            if (refAt >= otherVar.BeginLocation && refAt <= otherVar.ScopeEndLocation) {
                                otherVar.UsedNameArray[i] = true
                                return true
                            }

                            return false
                        })
                    } else {
                        throw "Unreachable"
                    }
                }
            })
        }
    })
}



// hi

let luaminp = {}

luaminp.Minify = function(scr, options) {
    print("Minifying")

    print("Creating lua parser...")
    let ast = CreateLuaParser(scr)
    print("Adding variable info")
    let [glb, root] = AddVariableInfo(ast)

    if (options.RenameVariables == true) {
        print("Renaming variables")
        MinifyVariables_2(glb, root, options.RenameGlobals)
    }

    if (options.SolveMath == true) {
        print("Solving math")
        SolveMath(ast) // oboy
    }

    print("Stripping ast")
    StripAst(ast)

    print("Printing ast")
    let result = PrintAst(ast)

    return result
}

module.exports.Minify = luaminp.Minify

/src/Bytecode/index.js

// Read and parse bytecode into a chunktree

const ReaderClass = require('../Bytecode/reader.js')
const opdata = require('../Bytecode/opdata.json')
let ChunkDecode
function error(Str) {
    throw Str
}

function bits(d) {
    let a = (d >>> 0).toString(2)
    return `${(8 - a.length) <= 0 ? '' : ('0').repeat(8 - a.length)}${a}`
}

let ExpectingSetListData = false
function ReadInstructions(reader, ConstantReferences, usedInstrs) {
    let Instructions = []
    let InstLen = reader.gInt()
    for (let Idx = 0; Idx < InstLen; Idx++) {
        let [ A, B, C, D ] = reader.gAscii(4)
        let InstBin = `${bits(D)}${bits(C)}${bits(B)}${bits(A)}`
        let Opco = parseInt(InstBin.substr(26, 6), 2)
        let Type = opdata.Opcode[Opco]
        let Mode = opdata.Opmode[Opco]

        usedInstrs[Opco] = true
        let Inst = {
            Enum: Opco,
            Value: reader.gBits32from([A, B, C, D]),
            Type: Type,
            Mode: Mode,
            IsDataType: false,
            Name: opdata.Opnames[Opco],
            References: [],
            BackReferences: [],
            ['1']: parseInt(InstBin.substr(18, 8), 2),
            ['2']: null,
            ['3']: null
        }

        switch (Type) {
            case 'ABC':
                Inst['2'] = parseInt(InstBin.substr(0, 9), 2)
                Inst['3'] = parseInt(InstBin.substr(9, 9), 2)
                break
            case 'ABx':
                Inst['2'] = parseInt(InstBin.substr(0, 18), 2)
                break
            case 'AsBx':
                Inst['2'] = parseInt(InstBin.substr(0, 18), 2) - 131071
                break
            default: break
        }

        if (ExpectingSetListData === true) {
            ExpectingSetListData = false
            Inst.IsDataType = true
            Instructions[Idx] = Inst
            continue
        }

        // TEST, TESTSET
        if (Opco == 26 || Opco == 27) { 
            Inst['3'] = Inst['3'] == 0
        }

        // EQ, LT, LE
        if (Opco >= 23 && Opco <= 25) {
            Inst['1'] = Inst['1'] != 0
        }

        // SETLIST
        if (Opco == 34 && Inst['3'] === 0) {
            ExpectingSetListData = true
        }


        Instructions[Idx] = Inst
    }
    return Instructions
}

class nil { t = 'nil' };
function ReadConstants(reader, ConstantReferences) {
    let Constants = []
    let LConst = reader.gInt()
    for (let Idx = 0; Idx < LConst; Idx++) {
        let Type = reader.gBits8()
        let Cons = null
        switch (Type) {
            case 1:
                Cons = (reader.gBits8() != 0)
                break
            case 3:
                Cons = reader.gFloat()
                break
            case 4:
                let str = reader.gString()
                Cons = str.substr(0, str.length - 1)
                break
            default: 
                //Cons = nil
                Cons = null;
                break
        }

        let Refs = ConstantReferences[Idx]
        if (Refs) {
            for (let i = 0; i < Refs.length; i++) {
                Refs[i].Inst[Refs[i].Register] = Cons
            }
        }

        Constants.push(Cons)
    }

    return Constants
}

function ReadProtos(tree, reader, UsedInstructions) {
    let Protos = []
    let LProto = reader.gInt()
    for (let Idx = 0; Idx < LProto; Idx++) {
        Protos.push(ChunkDecode(tree, reader, UsedInstructions))
    }
    return Protos
}

function SetupReferences(chunk, inst) {
    let Reference
    switch (inst.Name) {
        case 'LOADK':
        case 'GETGLOBAL':
        case 'SETGLOBAL':
            // add constant references?
            break

        case 'JMP':
        case 'FORLOOP':
        case 'FORPREP':
            //console.log(inst['2'], chunk.Instr.indexOf(inst), chunk.Instr.indexOf(inst) + inst['2'] + 1 )
            Reference = chunk.Instr[ chunk.Instr.indexOf(inst) + inst['2'] + 1 ]
            inst.References[0] = Reference
            Reference.BackReferences.push(inst)
            break
        
        case 'EQ':
        case 'LT':
        case 'LE':
            // add constant references?

            Reference = chunk.Instr[ chunk.Instr.indexOf(inst) + chunk.Instr[chunk.Instr.indexOf(inst) + 1]['2'] + 1 + 1 ]
            inst.References[2] = Reference
            Reference.BackReferences.push(inst)

            inst.JumpTo = chunk.Instr[chunk.Instr.indexOf(inst) + 1]
            break

        case 'TEST':
        case 'TESTSET':
        case 'TFORLOOP':
            Reference = chunk.Instr[ chunk.Instr.indexOf(inst) + chunk.Instr[chunk.Instr.indexOf(this) + 1]['2'] + 1 + 1 ]
            inst.References[2] = Reference
            Reference.BackReferences.push(inst)
            break
        
        case 'GETTABLE':
        case 'SETTABLE':
        case 'ADD':
        case 'SUB':
        case 'MUL':
        case 'DIV':
        case 'MOD':
        case 'POW':
        case 'SELF':
            // add constant references?
            break
        
    }
}

ChunkDecode = function(tree, reader, insts = null) {
    let ConstantReferences = []
    let UsedInstructions = insts || {}

    let Chunk = {
        Tree: tree,
        Name: reader.gString(),
        FirstL: reader.gInt(),
        LastL: reader.gInt(),
        Upvals: reader.gBits8(),
        Args: reader.gBits8(),
        Vargs: reader.gBits8(),
        Stack: reader.gBits8(),
        Instr: null,
        Const: null,
        Proto: null,
        Lines: [],
        Locals: [],
        Upvalues: [],
        Virtuals: []
    }

    Chunk.Instr = ReadInstructions(reader, ConstantReferences, UsedInstructions)
    for (let i = 0; i < Chunk.Instr.length; i++)
        SetupReferences(Chunk, Chunk.Instr[i])

    Chunk.Const = ReadConstants(reader, ConstantReferences)
    Chunk.Proto = ReadProtos(tree, reader, UsedInstructions)

    tree.TotalInstructions = (tree.TotalInstructions || 0) + Chunk.Instr.length

    if (Chunk.Name) {
        Chunk.Name = Chunk.Name.substr(0, Chunk.Name.length - 1)
    }
    if (insts == null) {
        Chunk.UsedInstructions = UsedInstructions
    }

    do { // Debug data

        // Lines
        const LLine = reader.gInt()
        for (let Idx = 0; Idx < LLine; Idx++) {
            Chunk.Lines.push(reader.gInt())

        }

        // Locals
        const LLocal = reader.gInt()
        for (let i = 0; i < LLocal; i++) {
            Chunk.Locals.push({
                Name: reader.gString(),
                FirstL: reader.gInt(),
                LastL: reader.gInt()
            })
        }

        // Upvalues
        const LUpv = reader.gInt()
        for (let i = 0; i < LUpv; i++) {
            Chunk.Upvalues.push(reader.gString())
        }
    } while (false) 
    
    return Chunk
}

function generateString(length) {
    var result           = '';
    var characters       = '_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    result += characters.charAt(Math.floor(Math.random() * characters.length - 10));
    length--;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}

function addOpcode(chunk, pos, name, opcode) {
    chunk.Tree.Chunk.UsedInstructions[name] = true
    if (chunk.Tree.Chunk.UsedInstructions != null)
        chunk.Tree.Chunk.UsedInstructions[name] = true;

    let ranName = chunk.Tree.Opmap[name] || null;
    if (ranName === null) {
        do {
            ranName = `x${generateString(8)}`
        } while (chunk.Tree.ROpmap[ranName])
    }
    opcode.Enum = ranName

    if (chunk.Tree.Opmap != null)
        chunk.Tree.Opmap[name] = ranName;
    if (chunk.Tree.ROpmap != null)
        chunk.Tree.ROpmap[ranName] = '' + name;

    opcode['1'] = opcode['1'] != undefined ? opcode['1'] : null
    opcode['2'] = opcode['2'] != undefined ? opcode['2'] : null
    opcode['3'] = opcode['3'] != undefined ? opcode['3'] : null
    opcode.References = []
    opcode.BackReferences = []
    opcode.IgnoreInstruction = true
    chunk.Instr.splice(pos, 0, opcode)
    return true;
}

module.exports = {
    DecodeBytestring: async function(byteString, settings) {
        console.log("BRUH,", byteString)
        const reader = new ReaderClass(byteString)

        if (settings.Debug) 
            console.log("Dumping headers")
        let Headers = {
            Signature: reader.gString(4),
            Version: reader.gBits8(),
            FormatVersion: reader.gBits8(),
            Endianness: reader.gBits8(),
            IntSize: reader.gBits8(),
            Sizet: reader.gBits8(),
            InstSize: reader.gBits8(),
            NumSize: reader.gBits8(),
            IntegralFlag: reader.gBits8(),
        }
    
        if (settings.Debug)
            console.log(`Setting gInt and gSizet, ${Headers.IntSize}, ${Headers.Sizet}`)

        if (Headers.IntSize === 4)
            reader.gInt = reader.gBits32
        else if(Headers.IntSize === 8) 
            reader.gInt = reader.gByte8
        else
            return error('Integer size not supported')

        if (Headers.Sizet === 4)
            reader.gSizet = reader.gBits32
        else if(Headers.Sizet === 8) 
            reader.gSizet = reader.gByte8
        else
            return error('Sizet size not supported')
        

        if (settings.Debug) 
            console.log("Dumping top chunk")
        let Tree = { Headers: Headers, Opmap: null, ROpmap: null, AddOpcode: addOpcode }
        Tree.Chunk = ChunkDecode(Tree, reader)
        Tree.nil = nil


        //console.log(Tree.Chunk)
        return Tree
    },
    Encoder: require('../Bytecode/encoder.js')
}

-- /src/Bytecode/opdata.json - Lua opcode data

{
	"Opmode": [
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgK", "c": "OpArgN"},
        {"b": "OpArgU", "c": "OpArgU"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgU", "c": "OpArgN"},
        {"b": "OpArgK", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgN"},
        {"b": "OpArgU", "c": "OpArgN"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgU", "c": "OpArgU"},
        {"b": "OpArgR", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgR"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgK", "c": "OpArgK"},
        {"b": "OpArgR", "c": "OpArgU"},
        {"b": "OpArgR", "c": "OpArgU"},
        {"b": "OpArgU", "c": "OpArgU"},
        {"b": "OpArgU", "c": "OpArgU"},
        {"b": "OpArgU", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgR", "c": "OpArgN"},
        {"b": "OpArgN", "c": "OpArgU"},
        {"b": "OpArgU", "c": "OpArgU"},
        {"b": "OpArgN", "c": "OpArgN"},
        {"b": "OpArgU", "c": "OpArgN"},
        {"b": "OpArgU", "c": "OpArgN"}
    ],

    "Opcode": [ 
        "ABC",	"ABx",	"ABC",	"ABC",
        "ABC",	"ABx",	"ABC",	"ABx",
        "ABC",	"ABC",	"ABC",	"ABC",
        "ABC",	"ABC",	"ABC",	"ABC",
        "ABC",	"ABC",	"ABC",	"ABC",
        "ABC",	"ABC",	"AsBx",	"ABC",
        "ABC",	"ABC",	"ABC",	"ABC",
        "ABC",	"ABC",	"ABC",	"AsBx",
        "AsBx",	"ABC",	"ABC",	"ABC",
        "ABx",	"ABC"
    ],

    "Opnames": [
        "MOVE", "LOADK", "LOADBOOL", "LOADNIL",
        "GETUPVAL", "GETGLOBAL", "GETTABLE",
        "SETGLOBAL", "SETUPVAL", "SETTABLE",
        "NEWTABLE", "SELF",
        "ADD", "SUB", "MUL", "DIV",
        "MOD", "POW", "UNM", "NOT",
        "LEN", "CONCAT", "JMP",
        "EQ", "LT", "LE", "TEST",
        "TESTSET", "CALL", "TAILCALL",
        "RETURN", "FORLOOP", "FORPREP",
        "TFORLOOP", "SETLIST", "CLOSE",
        "CLOSURE", "VARARG"
    ]
}


-- /src/Bytecode/encoder.js - Bytecode encoding

function frexp (arg) {
    //  discuss at: https://locutus.io/c/frexp/
    // original by: Oskar Larsson Högfeldt (https://oskar-lh.name/)
    arg = Number(arg)
    const result = [arg, 0]
    if (arg !== 0 && Number.isFinite(arg)) {
      const absArg = Math.abs(arg)
      const log2 = Math.log2 || function log2 (n) { return Math.log(n) * Math.LOG2E }
      let exp = Math.max(-1023, Math.floor(log2(absArg)) + 1)
      let x = absArg * Math.pow(2, -exp)
      while (x < 0.5) {
        x *= 2
        exp--
      }
      while (x >= 1) {
        x *= 0.5
        exp++
      }
      if (arg < 0) {
        x = -x
      }
      result[0] = x
      result[1] = exp
    }
    return result
}

let opdata = require('./opdata.json')
let encoder = {
    from_double: (x) => {
        let grab_byte = (v) => {
            let c = v % 256
            return [ (v - c) / 256, encoder.from_string(String.fromCharCode(c)) ]
        }
        let sign = 0
        if (x < 0) {
            sign = 1
            x = -x
        }
        let [ mantissa, exponent ] = frexp(x)
        if (x == 0) {
            mantissa = 0
            exponent = 0
        } else if(x == 1 / 0) {
            mantissa = 0
            exponent = 2047
        } else {
            mantissa = (mantissa * 2 - 1) * (0.5 * 2 ** 53)
            exponent = exponent + 1022
        }
        let [ v, byte ] = [ '', null ]
        x = Math.floor(mantissa)
        for (let i = 0; i < 6; i++) {
            [ x, byte ] = grab_byte(x);
            byte = v + byte;
        }
        [ x, byte ] = grab_byte(exponent * 16 + x)
        v = v + byte;
        [ x, byte ] = grab_byte(sign * 128 + x)
        v = v + byte;
        return v
    },

    from_int: (x) => {
        let v = ''
        x = Math.floor(x)
        if (x < 0) {
            x = 4294967296 + x
        }
        for (i = 0; i < 4; i++) {
            let c = x % 256
            v = v + encoder.from_string(String.fromCharCode(c))
            x = Math.floor(x / 256)
        }
        return v
    },

    from_string: (s) => {
        let e = ''
        for (let i = 0; i < s.length; i++) {
            let hex = s.substr(i, 1).charCodeAt().toString(16)
            e += `${(2 - hex.length) > 0 ? '0'.repeat(2 - hex.length) : ''}${hex}`
        }
        return e.toUpperCase()
    },

    dump_string: (s) => {
        if (typeof s == 'string') {
            s += '\0'
            return `${encoder.from_int(s.length)}${encoder.from_string(s)}`
        } else {
            return encoder.from_int(0)
        }
    },

    dump_char: (y) => {
        return encoder.from_string(String.fromCharCode(y))
    },

    dump_headers: (headers) => {
        return encoder.from_string(headers.Signature) + 
            + encoder.dump_char(headers.Version)
            + encoder.dump_char(headers.FormatVersion)
            + encoder.dump_char(headers.Endianness)
            + encoder.dump_char(headers.IntSize)
            + encoder.dump_char(headers.Sizet)
            + encoder.dump_char(headers.InstSize)
            + encoder.dump_char(headers.NumSize)
            + encoder.dump_char(headers.IntegralFlag)
    },

    dump_instructions: (insts) => {
        let to_mbits = (n, l = 8) => {
            let s = n.toString(2)
            return `${'0'.repeat(Math.max(0, l - s.length))}${s}`
        }
        let s = ''
        s += encoder.from_int(insts.length)
        for (let Idx = 0; Idx < insts.length; Idx++) {
            let sinst = ''
            let Inst = insts[Idx]
            if (Inst.Enum == 26 || Inst.Enum == 27) {
                Inst[3] = Inst[3] ? 0 : 1
            } else if(Inst.Enum >= 23 && Inst.Enum <= 25) {
                Inst[1] = Inst[1] ? 1 : 0
            }

            let Type
            switch (Inst.Type) {
                case 'ABC':
                    Type = Type || 1
                    sinst += to_mbits(Inst[2], 9)
                    sinst += to_mbits(Inst[3], 9)
                    sinst += to_mbits(Inst[1], 8)
                    break
                case 'ABx':
                    Type = Type || 2
                case 'AsBx':
                    Type = Type || 3
                    sinst += to_mbits(Inst[2], 18)
                    sinst += to_mbits(Inst[1], 8)
                    break
                case 'NOP':
                    Type = Type || 4
                    sinst += to_mbits(Math.floor(Math.random() * 10 + 1), 26)
                    break
                default: break
            }
            sinst += to_mbits(Inst.Enum, 6)

            let [ A, B, C, D ] = sinst.match(/......../g)
            s += encoder.dump_char(parseInt(D, 2))
            s += encoder.dump_char(parseInt(C, 2))
            s += encoder.dump_char(parseInt(B, 2))
            s += encoder.dump_char(parseInt(A, 2))
            s += encoder.dump_char(Type)
            s += encoder.dump_char(parseInt(
                to_mbits(Inst.Mode.b == 'OpArgK' ? 1 : 0, 4) 
                + to_mbits(Inst.Mode.c == 'OpArgK' ? 1 : 0, 4), 
            2))
        }
        return s
    },

    dump_constants: (consts) => {
        let s = ''
        s += encoder.from_int(consts.length);
        for (let Idx = 0; Idx < consts.length; Idx++) {
            let const_ = consts[Idx]
            let type = const_ == null ? 0 
                : typeof const_ == 'boolean' ? 1
                : typeof const_ == 'number' ? 3
                : 4
            s += encoder.dump_char(type)
            switch (type) {
                case 0:
                    break
                case 1:
                    s += encoder.dump_char(_const ? 1 : 0)
                    break
                case 3:
                    s += encoder.from_double(const_)
                    break
                case 4:
                    s += encoder.dump_string(const_)
                    break
                default: break
            }
        }
        

        return s
    },

    dump_protos: (protos, debug) => {
        let s = ''
        s += encoder.from_int(protos.length)
        for (let Idx = 0; Idx < protos.length; Idx++) {
            let proto = protos[Idx]
            s += encoder.dump_chunk(proto, debug)
        }
        return s
    },

    dump_debugdata: (lines, locals, upvalues) => {
        let s = ''

        s += encoder.from_int(lines.length)
        for (let Idx = 0; Idx < lines.length; Idx++) {
            s += encoder.from_int(lines[Idx])
        }

        s += encoder.from_int(locals.length)
        for (let Idx = 0; Idx < locals.length; Idx++) {
            let local = locals[idx]
            s += encoder.from_string(local.Name)
            s += encoder.from_int(local.FirstL)
            s += encoder.from_int(local.LastL)
        }

        s += encoder.from_int(upvalues.length)
        for (let Idx = 0; Idx < upvalues.length; Idx++) {
            s += encoder.from_string(upvalues[Idx])
        } 



        return s
    },

    dump_chunk: (chunk, debug = false) => {
        let s = ''
        if (debug) {
            s += encoder.dump_string(chunk.Name)
            s += encoder.from_int(chunk.FirstL)
            s += encoder.from_int(chunk.LastL)
        }
        s += encoder.dump_char(chunk.Upvals)
        s += encoder.dump_char(chunk.Args)
        if (debug) {
            s += encoder.dump_char(chunk.Vargs)
            s += encoder.dump_char(chunk.Stack)
        }

        s += encoder.dump_instructions(chunk.Instr)
        s += encoder.dump_constants(chunk.Const)
        s += encoder.dump_protos(chunk.Proto, debug)

        if (debug) {
            s += encoder.dump_debugdata(chunk.Lines, chunk.Locals, chunk.Upvalues)
        }

        return s
    },

    dump_tree: (tree, debug) => {
        let bytecode = ''
        let headers = encoder.dump_headers(tree.Headers)
        let chunk = encoder.dump_chunk(tree.Chunk, false)

        bytecode += headers
        bytecode += chunk
        return bytecode
    }
}
module.exports = encoder


-- /src/Bytecode/reader.js - Bytecode reading

// Read the bytecode

function bits(d) {
    let a = (d >>> 0).toString(2)
    return `${(8 - a.length) <= 0 ? '' : ('0').repeat(8 - a.length)}${a}`
}

module.exports = class Reader {
    constructor(bytes) {
        this.bytes = bytes
        this.gSizet = null
        this.gInt = null
        this.pos = 0
    }

    gAscii(len = 1) {
        let nums = []
        for (let i = 0; i < len; i++) {
            nums.push(this.bytes[this.pos])
            this.pos += 1
        }
        return nums  
    }

    gBits32from(a) {
        return (a[0] * 1)
            + (a[1] * 256) 
            + (a[2] * 65536) 
            + (a[3] * 16777216)
    }

    read(len = 1) {
        let str = ''
        for (let i = 0; i < len; i++) {
            str += String.fromCharCode(this.gAscii()[0])
        }
        return str
    }

    gBits8() {
        return this.gAscii()[0]
    }

    gBits32() {
        let [ W, X, Y, Z ] = this.gAscii(4)
        return (W * 1)
            + (X * 256)
            + (Y * 65536)
            + (Z * 16777216)
    }

    gBits64() {
        return this.gBits32() * 4294967296 + this.gBits32()
    }

    gByte8() {
        return this.gBits32() + this.gBits32() // not an integer
    }

    gFloat() {
        let Left = this.gBits32()
        let [ A, B, C, D ] = this.gAscii(4)
        let Right = this.gBits32from([A, B, C, D])
        let IsNormal = 1
        let RightBits = `${bits(D)}${bits(C)}${bits(B)}${bits(A)}`
        let Mantissa = (parseInt(RightBits.substr(12, 20), 2) 
            * (2 ** 32)) + Left
        let Exponent = parseInt(RightBits.substr(1, 11), 2)
        let Sign = ((-1) ** parseInt(RightBits.substr(0, 1), 2))

        if (Exponent == 0) {
            if (Mantissa == 0) {
                return Sign * 0
            } else {
                Exponent = 1
                IsNormal = 0
            }
        } else if(Exponent == 2047) {
            if (Mantissa == 0) {
                return Sign * (1 / 0)
            } else {
                return Sign * (0 / 0)
            }
        }

        return (Sign * (2 ** (Exponent - 1023))) * (IsNormal + (Mantissa / (2 ** 52)))
    }

    gString(Len = this.gSizet()) {
        return Len == 0 ? '' : this.read(Len)
    }
}

-- /src/Bytecode/vanilla_encoder.js - Standard bytecode encoding

function frexp (arg) {
    //  discuss at: https://locutus.io/c/frexp/
    // original by: Oskar Larsson Högfeldt (https://oskar-lh.name/)
    arg = Number(arg)
    const result = [arg, 0]
    if (arg !== 0 && Number.isFinite(arg)) {
      const absArg = Math.abs(arg)
      const log2 = Math.log2 || function log2 (n) { return Math.log(n) * Math.LOG2E }
      let exp = Math.max(-1023, Math.floor(log2(absArg)) + 1)
      let x = absArg * Math.pow(2, -exp)
      while (x < 0.5) {
        x *= 2
        exp--
      }
      while (x >= 1) {
        x *= 0.5
        exp++
      }
      if (arg < 0) {
        x = -x
      }
      result[0] = x
      result[1] = exp
    }
    return result
}

let opdata = require('../Bytecode/opdata.json')
let encoder = {
    from_double: (x) => {
        let grab_byte = (v) => {
            let c = v % 256
            return [ (v - c) / 256, encoder.from_string(String.fromCharCode(c)) ]
        }
        let sign = 0
        if (x < 0) {
            sign = 1
            x = -x
        }
        let [ mantissa, exponent ] = frexp(x)
        if (x == 0) {
            mantissa = 0
            exponent = 0
        } else if(x == 1 / 0) {
            mantissa = 0
            exponent = 2047
        } else {
            mantissa = (mantissa * 2 - 1) * (0.5 * 2 ** 53)
            exponent = exponent + 1022
        }
        let [ v, byte ] = [ '', null ]
        x = Math.floor(mantissa)
        for (let i = 0; i < 6; i++) {
            [ x, byte ] = grab_byte(x);
            byte = v + byte;
        }
        [ x, byte ] = grab_byte(exponent * 16 + x)
        v = v + byte;
        [ x, byte ] = grab_byte(sign * 128 + x)
        v = v + byte;
        return v
    },

    from_int: (x) => {
        let v = ''
        x = Math.floor(x)
        if (x < 0) {
            x = 4294967296 + x
        }
        for (i = 0; i < 4; i++) {
            let c = x % 256
            v = v + encoder.from_string(String.fromCharCode(c))
            x = Math.floor(x / 256)
        }
        return v
    },

    from_string: (s) => {
        let e = ''
        for (let i = 0; i < s.length; i++) {
            let hex = s.substr(i, 1).charCodeAt().toString(16)
            e += `${(2 - hex.length) > 0 ? '0'.repeat(2 - hex.length) : ''}${hex}`
        }
        return e.toUpperCase()
    },

    dump_string: (s) => {
        if (typeof s == 'string') {
            s += '\0'
            return `${encoder.from_int(s.length)}${encoder.from_string(s)}`
        } else {
            return encoder.from_int(0)
        }
    },

    dump_char: (y) => {
        return encoder.from_string(String.fromCharCode(y))
    },

    dump_headers: (headers) => {
        return encoder.from_string(headers.Signature) + 
            + encoder.dump_char(headers.Version)
            + encoder.dump_char(headers.FormatVersion)
            + encoder.dump_char(headers.Endianness)
            + encoder.dump_char(headers.IntSize)
            + encoder.dump_char(headers.Sizet)
            + encoder.dump_char(headers.InstSize)
            + encoder.dump_char(headers.NumSize)
            + encoder.dump_char(headers.IntegralFlag)
    },

    dump_instructions: (insts) => {
        let to_mbits = (n, l = 8) => {
            let s = n.toString(2)
            return `${'0'.repeat(Math.max(0, l - s.length))}${s}`
        }
        let s = ''
        s += encoder.from_int(insts.length)
        for (let Idx = 0; Idx < insts.length; Idx++) {
            let sinst = ''
            let Inst = insts[Idx]
            if (Inst.Enum == 26 || Inst.Enum == 27) {
                Inst[3] = Inst[3] ? 0 : 1
            } else if(Inst.Enum >= 23 && Inst.Enum <= 25) {
                Inst[1] = Inst[1] ? 1 : 0
            }

            switch (Inst.Type) {
                case 'ABC':
                    sinst += to_mbits(Inst[2], 9)
                    sinst += to_mbits(Inst[3], 9)
                    sinst += to_mbits(Inst[1], 8)
                    break
                case 'ABx':
                case 'Asbx':
                    sinst += to_mbits(Inst[2], 18)
                    sinst += to_mbits(Inst[1], 8)
                    break
                default: break
            }
            sinst += to_mbits(Inst.Enum, 6)

            let [ A, B, C, D ] = sinst.match(/......../g)
            s += encoder.dump_char(parseInt(D, 2))
            s += encoder.dump_char(parseInt(C, 2))
            s += encoder.dump_char(parseInt(B, 2))
            s += encoder.dump_char(parseInt(A, 2))
        }
        return s
    },

    dump_constants: (consts) => {
        let s = ''
        s += encoder.from_int(consts.length);
        for (let Idx = 0; Idx < consts.length; Idx++) {
            let const_ = consts[Idx]
            let type = const_ == null ? 0 
                : typeof const_ == 'boolean' ? 1
                : typeof const_ == 'number' ? 3
                : 4
            s += encoder.dump_char(type)
            switch (type) {
                case 0:
                    break
                case 1:
                    s += encoder.dump_char(_const ? 1 : 0)
                    break
                case 3:
                    s += encoder.from_double(const_)
                    break
                case 4:
                    s += encoder.dump_string(const_)
                    break
                default: break
            }
        }
        

        return s
    },

    dump_protos: (protos) => {
        let s = ''
        s += encoder.from_int(protos.length)
        for (let Idx = 0; Idx < protos.length; Idx++) {
            let proto = protos[Idx]
            s += encoder.dump_chunk(proto)
        }
        return s
    },

    dump_debugdata: (lines, locals, upvalues) => {
        let s = ''

        s += encoder.from_int(lines.length)
        for (let Idx = 0; Idx < lines.length; Idx++) {
            s += encoder.from_int(lines[Idx])
        }

        s += encoder.from_int(locals.length)
        for (let Idx = 0; Idx < locals.length; Idx++) {
            let local = locals[idx]
            s += encoder.from_string(local.Name)
            s += encoder.from_int(local.FirstL)
            s += encoder.from_int(local.LastL)
        }

        s += encoder.from_int(upvalues.length)
        for (let Idx = 0; Idx < upvalues.length; Idx++) {
            s += encoder.from_string(upvalues[Idx])
        } 



        return s
    },

    dump_chunk: (chunk) => {
        let s = ''
        s += encoder.dump_string(chunk.Name)
        s += encoder.from_int(chunk.FirstL)
        s += encoder.from_int(chunk.LastL)
        s += encoder.dump_char(chunk.Upvals)
        s += encoder.dump_char(chunk.Args)
        s += encoder.dump_char(chunk.Vargs)
        s += encoder.dump_char(chunk.Stack)

        s += encoder.dump_instructions(chunk.Instr)
        s += encoder.dump_constants(chunk.Const)
        s += encoder.dump_protos(chunk.Proto)
        s += encoder.dump_debugdata(chunk.Lines, chunk.Locals, chunk.Upvalues)

        return s
    },

    dump_tree: (tree) => {
        let bytecode = ''
        let headers = encoder.dump_headers(tree.Headers)
        let chunk = encoder.dump_chunk(tree.Chunk)

        bytecode += headers
        bytecode += chunk
        return bytecode
    }
}
module.exports = encoder

-- /src/Generator/index.js - Main generator logic


/*
    generator.js - herrtt
*/

const date = new Date()

let lastTime = null;
const print =() => null;/*
    let newT = new Date().getTime()
    let diff = newT - (lastTime === null ? newT : lastTime)
    lastTime = newT
    console.log(`| ms since l.p.`, diff, `| :`, x)
}*/

const fs = require('fs');
const path = require('path');
function xorStrArr(bytes, key) {
    let result = [];
    let j = 0;
    for (let i = 0; i < bytes.length; ++i) {
      result[i] = (typeof(bytes[i]) == 'string'
      	? bytes[i].charCodeAt() : bytes[i]) ^ key.charCodeAt(j);
      ++j;
      if (j >= key.length) {
        j = 0;
      }
    }
    return result;
}


const opdata = require('../Bytecode/opdata.json')
const vmPath = path.join(global.TopDir, 'vm')
const vm = {
    opcodes: []
}


for (let Idx = 0; Idx < opdata.Opnames.length; Idx++) {
    let opname = opdata.Opnames[Idx]
    let path_ = path.join(vmPath, 'opcodes', `${opname}.lua`)
    if (fs.existsSync(path_)) {
        vm.opcodes[Idx] = {
            name: opname,
            code: fs.readFileSync(path_).toString()
        }
    }
}

var customOpcodeFiles = fs.readdirSync(path.join(vmPath, 'customOpcodes'))
for (filename of customOpcodeFiles) {
    let name = filename.split('.').slice(0, -1).join('.') // Sliced file extension
    vm.opcodes[name] = {
        name: name,
        code:  fs.readFileSync(path.join(vmPath, 'customOpcodes', filename)).toString()
    }
}

function shuffleArray(array) {
    var currentIndex = array.length,  randomIndex;
  
    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
  
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
  
      // And swap it with the current element.
      [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
  
    return array;
}

function genString(length) {
    var result           = '';
    var characters       = '_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    result += characters.charAt(Math.floor(Math.random() * characters.length - 10));
    length--;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}

function makeId(length) {
    var result           = '';
    var characters       = '_xXyYzoOiIlLZ0123456789';
    var charactersLength = characters.length;
    result += characters.charAt(Math.floor(Math.random() * (characters.length - 10 )));
    length--;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}

function toEscStr(arr) {
    let a = ''
    if (arr.length > 0)
        a += '\\'
    return a + arr.join('\\')
}

function toEscStrF(str) {
    let a = ''
    for (let i = 0; i < str.length; i++)
        a += `\\${str.charCodeAt(i)}`
    return a
}

function cControlFlow(code, n = Math.floor(Math.random() * 7000), a = Math.floor(Math.random() * 7000), depth = 0, depthValues) {
    depthValues = depthValues || []
    depthValues.push([ n, a ])

    let src = depth === 0 ? `local N_1_ = ${n};\nlocal A_1_ = ${a};\n` : '';
    if (n < a) {
        src += `while (N_1_ < A_1_) do\n` 
        src += `A_1_ = N_1_ - ${a * 2};\n`
        a = n - (a * 2)
        depthValues[depth][2] = '1'
    } else if(n > a) {
        let ran = Math.floor(Math.random() * 5000) + 10
        src += `while (N_1_ > (A_1_ - ${Math.floor(Math.random() * 3) + 10})) do\n`
        src += `A_1_ = (N_1_ + ${ran}) * 2;\n`
        a = (n + ran) * 2;
        depthValues[depth][2] = '2'
    } else if(n === a) {
        let ran = Math.floor(Math.random() * 5000) + 10
        src += `while (N_1_ == A_1_) do\n`
        src += `A_1_ = (N_1_ + ${ran}) * 2;\n`
        a = (n + ran) * 2;
        depthValues[depth][2] = '3'
    }

    if (depth === (code.length - 1)) {
        src += `${code.shift()}\n`;
    } else {
    	let [ _1, _2, _3 ]  = cControlFlow(code, n, a, depth + 1, depthValues)
        src += _1
        n = _2
        a = _3 
    }
    src += `end;\n`

    let dp = depthValues[depth - 1] 
    if (dp != undefined) {
        let [ dn, da, dt ] = dp
        if (n > a) {
            src += `if N_1_ > (A_1_ - ${n * 2}) then\n`
        } else if(n < a) {
            src += `if (${n * 2} - N_1_) < (A_1_ + ${n + Math.floor(Math.random() * 50)}) then\n`
        } else if(n == a) {
            src += `if N_1_ == A_1_ then\n`
        }

        if (dt == '1') {
            src += `N_1_ = ((A_1_ + ${dn}) * 2);\n`
            n = (a + dn) * 2
            if (code[0] != undefined)
                src += `${code.shift()}\n`
            src += `end;\n`
        } else if(dt == '2') {
            src += `A_1_ = (N_1_ + ${(dn) * 2});\n`
            a = n + (dn) * 2
            if (code[0] != undefined)
                src += `${code.shift()}\n`
            src += `end;\n`
        } else if(dt == '3') {
            src += `N_1_ = (A_1_ / 2) - ${dt * 2};\n`
            n = (a / 2) - (dt * 2)
            if (code[0] != undefined)
                src += `${code.shift()}\n`
            src += `end;\n`
        }
    }

	return depth === 0 ? src : [ src, n, a ] 
}

let opstatTypes = [
    `if (__A__ ~= __X__) then\n\t--RELOOP\nelse\n\t--CODE_A\nend;`,
    `if (__X__ ~= __A__) then\n\t--RELOOP\nelse\n\t--CODE_A\nend;`,
    `if (__A__ == __X__) then\n\t--CODE_A\nelse\n\t--RELOOP\nend;`,
    `if (__X__ == __A__) then\n\t--CODE_A\nelse\n\t--RELOOP\nend;`,

    `if (__A__ ~= __X__) then\n\t--RELOOP\nelseif (__X__ == __A__) then\n\t--CODE_A\nend;`,
    `if (__X__ ~= __A__) then\n\t--RELOOP\nelseif (__A__ == __X__) then\n\t--CODE_A\nend;`,
    `if (__A__ == __X__) then\n\t--CODE_A\nelseif (__X__ ~= __A__) then\n\t--RELOOP\nend;`,
    `if (__X__ == __A__) then\n\t--CODE_A\nelseif (__X__ ~= __A__) then\n\t--RELOOP\nend;`
]

let replaceAll = (str, ser, rep) => 
    str.split(ser).join(rep)

function generateSuperOp(virtual, tree) {
    let obf = ''

    //console.log(virtual.Name)
    virtual.Instructions.forEach((v, i) => {
        if (v !== null) {
            //console.log( v.Name, v.Enum, v.Name.toString(), tree.ROpmap[v.Name.toString()])
            obf += `\nInst = Chunk['|Inst|'][pc]; pc = pc + 1;\n`
            obf += vm.opcodes[tree.ROpmap[v.Enum.toString()]].code
        }
    })


    return obf
}

function CreateOpcodeStat(opcodes, fakeCode = [], tree, debug = false, d = 0) {
    
    let type = Math.floor(Math.random() * opstatTypes.length)
    let codeR = opstatTypes[type]
    let s = ''
    let codeA
    let name
    if (typeof opcodes[0] === 'object') {
        if (opcodes[0].fake === true) {
            name = opcodes[0].name
            codeA = { code: (shuffleArray(fakeCode)[0] !== null && fakeCode[0] !== undefined) ? fakeCode[0] : '', fake: true }
        } else {
            name = opcodes[0].Name
            codeA = { code: generateSuperOp(opcodes[0], tree), fake: true , name: 'ban'}
        }

    } else {
        name = opcodes[0]
        codeA = vm.opcodes[tree.ROpmap[opcodes[0].toString()]]
    }

    if (!codeA) {
        throw `Missing ${opdata.Opnames[tree.ROpmap[opcodes[0].toString()]]}, ${tree.ROpmap[opcodes[0].toString()]}`; 
    }

    if (codeA.fake !== true && debug !== true && codeA.modified !== true) {
        //codeA.code = cControlFlow([ codeA.code ])
        codeA.modified = true
    }

    codeR = replaceAll(codeR, '__A__', `"${name}"` )
    codeR = replaceAll(codeR, '__X__', 'OP_CODE')
    codeR = replaceAll(codeR, '--CODE_A', codeA.code)
    codeR = replaceAll(codeR, '\n', '\n' + (d <= 0 ? '' : '\t'.repeat(d)))
    if (opcodes.length <= 1) {
        codeR = replaceAll(codeR, '--RELOOP', '')
    } else {
        opcodes.shift()
        codeR = replaceAll(codeR, '--RELOOP', CreateOpcodeStat(opcodes, fakeCode, tree, debug, d + 1))
    }

    s += codeR
    return s
}

function from_int(x, b = 4) {
    let v = []
    x = Math.floor(x)
    if (x < 0) {
        x = 4294967296 + x
    }
    for (i = 0; i < b; i++) {
        let c = x % 256
        v.push(c)
        x = Math.floor(x / 256)
    }
    return v
}

function updateRegisters(inst, chunk) {
    if (inst.IsDataType)
        return;
    
    inst.InstrPoint = chunk.Instr.indexOf(inst)
    //console.log("UPD:", inst.Name)
    switch (inst.Name) {
        case 'LOADK':
        case 'GETGLOBAL':
        case 'SETGLOBAL':
            // Update constants (later?)
            break

        case 'JMP':
        case 'FORLOOP':
        case 'LOADJUMP': // Custom
        case 'FORPREP':
            //console.log("WA:", inst['2'], chunk.Instr.indexOf(inst.References[0]) - chunk.Instr.indexOf(inst) - 1)
            inst['2'] = chunk.Instr.indexOf(inst.References[0]) - chunk.Instr.indexOf(inst) - 1
            break
        default: break
    }

}

function CreateInstDecoder(chunk, tree, settings) {
    let createControlFlow = settings.Debug === true ?  c => c.join('\n') : cControlFlow;
    let dec = ''
    
    
    let eTypes = {
        ABC: 'a',
        ABx: 'b',
        AsBx: 'x',
        NOP: 'n',
        SOP: 's'
    }

    let BooleanEnc = {
        True: 'x',
        False: 'y'
    }

    dec += `
    local usedInstsCache = { }
    local function decodeLoadStr(str)
        local t = { }
        local p = 1
        local l = #str - 1
    
    
        local read = function(len)
            len = len or 1
            local c = sub(str, p, p + (len - 1))
            p = p + len
            return c 
        end

        
        local gByte2 = function()
            local x, y = byte(str, p, p + 1)
            p = p + 2
            return (y * 256) + x
        end	

        local gByte3 = function()
            local x, y, z = byte(str, p, p + 2)
            p = p + 3
            return (z * 65536) + (y * 256) + x
        end	
    
        local gByte4 = function()
            local w, x, y, z = byte(str, p, p + 3)
            p = p + 4
            return (z * 16777216) + (y * 65536) + (x * 256) + w;
        end

        local gByte5 = function()
            local w, x, y, z, a = byte(str, p, p + 4)
            p = p + 5
            return (z * 16777216) + (y * 65536) + (x * 256) + w
                + (a * 4294967296);
        end
    
        local char0, char1, char2, char3 = char(0), char(1), char(2), char(3)
        local _n1, _n2, _n3 = byte(char1), byte(char2), byte(char3)
        local _INST = VM["__instr__"];
        local gABC = function()
            local a, b, c;
            local type = read()
            if (type == "${eTypes.NOP}" or type == "${eTypes.SOP}") then
                return a, b, c
            else
                local t1 = read()
                if t1 == char0 then
                    a = byte(read())
                elseif t1 == char1 then
                    a = read() == '${BooleanEnc.True}'
                end

                local t2 = read()
                if t2 == char0 then
                    local num = (type == "${eTypes.ABC}") and gByte3() or gByte4()
                    if (type == "${eTypes.AsBx}") then
                        num = num - 131071;
                    end
                    b = num
                elseif t2 == char1 then
                    b = read() == '${BooleanEnc.True}'
                end

                if (type == "${eTypes.ABC}") then
                    local t3 = read()
                    if t3 == char0 then
                        c = gByte3()
                    elseif t3 == char1 then
                        c = read() == '${BooleanEnc.True}'
                    end
                end

                return a, b, c
            end
        end

        while true do
            local c = read()
            --print("=>", c:byte(), p)
            ${shuffleArray([
                `if c == char0 then -- addinst
                    local Inst = {};
                    local opn_size = byte(read());
                    local opname = read(opn_size);
                    local a, b, c = gABC();
                    ${shuffleArray([
                        "Inst[_n1] = a;",
                        "Inst[_n2] = b;",
                        "Inst[_n3] = c;",
                        `Inst["__value__"] = gByte5();`
                    ]).join('\n')}
                    --print("-", opname, a, b, c, Inst["__value__"]);
                    VM(opname)(Inst);
                    local index = gByte4();
                    usedInstsCache[index] = opname;
                end;`,
                `if c == char1 then -- addinst from cache
                    local Inst = {};
                    local index = byte(read());--gByte4();
                    local opname = usedInstsCache[index];
                    local a, b, c = gABC();
                    ${shuffleArray([
                        "Inst[_n1] = a;",
                        "Inst[_n2] = b;",
                        "Inst[_n3] = c;",
                        `Inst["__value__"] = gByte5();`
                    ]).join('\n')}

                    --print("-", opname, a, b, c, Inst["__value__"]);
                    VM(opname)(Inst);
                end`,
                `if c == char2 then -- break
                    break
                end`
            ]).join('\n')}
    
            if p > l then
                break
            end
        end;
    
        for i,v in pairs(usedInstsCache) do 
            usedInstsCache[i] = nil; 
        end;
        usedInstsCache = nil;

        return t;
    end
    `

    let instCache = {}
    let cIdx = 0
    let s = ''
    for (let idx in chunk.Instr) {
        let inst = chunk.Instr[idx]
        if (inst === null)
            continue;


         //console.log("-1>", inst.Name, inst['1'], inst['2'], inst['3'])
         updateRegisters(inst, chunk)
         //console.log("-2>", inst.Name, inst['1'], inst['2'], inst['3'])

        let cacheIdx = instCache[inst.Enum]
        let inCache = typeof cacheIdx === 'number'
        if (!inCache)
            cacheIdx = ++cIdx;

        s += `\\${inCache ? 1 : 0}`;

        if (inCache)
            s += `\\${from_int(cacheIdx, 1).join('\\')}`;
        else
            s += `\\${from_int(inst.Enum.length, 1).join('\\')}${inst.Enum}`; // Name Length + Name

        s += (eTypes[inst.Type]); // Type
        if (inst.Type === 'SOP' || inst.Type === 'NOP') {
            s += `\\${from_int(inst.Value, 5).join('\\')}`;
            if (!inCache) {
                instCache[inst.Enum] = cIdx;
                s += `\\${from_int(cIdx).join('\\')}`;
            }
        } else {
            if (typeof inst['1'] === 'boolean')
                s += `\\1${inst['1'] === true ? BooleanEnc.True : BooleanEnc.False}`;
            else
                s += `\\0\\${from_int(inst['1'] === null ? 0 : inst['1'], 1).join('\\')}`;

            if (typeof inst['2'] === 'boolean')
                s += `\\1${inst['2'] === true ? BooleanEnc.True : BooleanEnc.False}`;
            else {
                let n = inst['2'] === null ? 0 : inst['2'];
                if (inst.Type === 'AsBx')
                    n = n + 131071;
                s += `\\0\\${from_int(n, inst.Type === 'ABC' ? 3 : 4).join('\\')}`;
            }

            if (inst['3'] !== null) {
                if (typeof inst['3'] === 'boolean')
                    s += `\\1${inst['3'] === true ? BooleanEnc.True : BooleanEnc.False}`;
                else
                    s += `\\0\\${from_int(inst['3'] === null ? 0 : inst['3'], 3).join('\\')}`;
            }

            s += `\\${from_int(inst.Value, 5).join('\\')}`;
            if (!inCache) {
                instCache[inst.Enum] = cIdx;
                s += `\\${from_int(cIdx).join('\\')}`;
            }
        }
    }
    s += `\\2`;

    dec += `
    decodeLoadStr(|INST_LOAD_VAR|);
    `

    return [ dec, s ]
}


module.exports = {
    Generate: async function(tree, settings) {
        print("Generating code")
        let strs = []
        function genUniString(l = 9) {
            let res
            do {
                res = `x${makeId(l)}`
            } while (strs.includes(res))
            strs.push(res)
            return res
        }

        let s = ''
        //s += vm.start

        print("creating keys and unique names")
        let ranKey = genString(12)
        let ranKey2 = `_${genUniString()}`
        let stringGmatchIdx = `_${genUniString(15)}`
        let stringCharIdx = `_${genUniString(15)}`
        let stringByteIdx = `_${genUniString(15)}`
        let mtIdxStr = `_${genUniString(Math.floor(Math.random() * 6) + 12)}`
        let xorName = `_${genUniString(16)}`

        print("preparing control flow")
        let createControlFlow = settings.Debug === true ?  c => c.join('\n') : cControlFlow

        print("creating header and bits functions")

        let watermarkStart = `\nlocal ${shuffleArray([ 'CONST_TABLE', 'gfenv', 'WATERMARK' ]).join(', ')} = nil, nil, nil;\n([[${settings.Watermark}]]):gsub('IGNORE:(.*)', function(w)

            ${(shuffleArray([
                `local watermark = "IGNORE:${genString(Math.floor(Math.random() * 20) + 5)}";`,
                `local Shit = "IGNORE:${genString(Math.floor(Math.random() * 20) + 5)}";`, 
            ])).join('\n')}
            ${createControlFlow(shuffleArray([
                "watermark = w",
                "Shit = w",
                "gfenv = getfenv or function() return _ENV end;"
            ]))}
            
            local __ENV__ = gfenv();
            local charConst = __ENV__["IGNORE:string"]["IGNORE:${toEscStrF("char")}"](${("char").split('').map(v => v.charCodeAt()).join(', ')})
            local string = __ENV__[string[charConst](${("string").split('').map(v => v.charCodeAt()).join(', ')})];
            ${(shuffleArray([
                `local byte = "IGNORE:${genString(Math.floor(Math.random() * 20) + 2)}";`,
                `local char = "IGNORE:${genString(Math.floor(Math.random() * 20) + 2)}";`, 
                `local gmatch = "IGNORE:${genString(Math.floor(Math.random() * 20) + 2)}";`  
            ])).join('\n')}

            ${createControlFlow([
                `char = __ENV__[string[charConst](${("string").split('').map(v => v.charCodeAt()).join(', ')})][charConst];`,
                `byte = __ENV__[string[charConst](${("string").split('').map(v => v.charCodeAt()).join(', ')})][string[charConst](${("byte").split('').map(v => v.charCodeAt()).join(', ')})];`,
                `gmatch = __ENV__[string[charConst](${("string").split('').map(v => v.charCodeAt()).join(', ')})][string[charConst](${("gmatch").split('').map(v => v.charCodeAt()).join(', ')})];`
            ])}
            CONST_TABLE = {
                [watermark] = ${settings.Watermark.length},
                ['IGNORE:${toEscStrF("_")}' .. char(${(settings.Watermark).split('').map(v => v.charCodeAt()).join(', ')}) ] = Shit
            }

            CONST_TABLE[string[charConst](${(stringByteIdx).split('').map(v => v.charCodeAt()).join(', ')})] = byte;
            CONST_TABLE[string[charConst](${(stringCharIdx).split('').map(v => v.charCodeAt()).join(', ')})] = char;
            CONST_TABLE[string[charConst](${(stringGmatchIdx).split('').map(v => v.charCodeAt()).join(', ')})] = gmatch;
            ${createControlFlow([
                `if (CONST_TABLE[watermark] ~= nil and (#Shit ~= CONST_TABLE[watermark])) then return 0; end;`,
                `if (char(${(settings.Watermark).split('').map(v => v.charCodeAt()).join(', ')}) ~= watermark) then return false; end`,
                `if (Shit ~= CONST_TABLE['IGNORE:${toEscStrF("_")}' .. watermark]) then return ""; end;`,
                `WATERMARK = watermark`,
            ])}

            WATERMARK = watermark;
            CONST_TABLE[watermark] = nil;
        end);
        local char = CONST_TABLE["IGNORE:${stringCharIdx}"];
        local byte = CONST_TABLE["IGNORE:${stringByteIdx}"];
        local gmatch = CONST_TABLE["IGNORE:${stringGmatchIdx}"];
        local string = gfenv()[char(${("string").split('').map(v => v.charCodeAt()).join(', ')})];
        local format = string[char(${("format").split('').map(v => v.charCodeAt()).join(', ')})];
        local sub = string[char(${("sub").split('').map(v => v.charCodeAt()).join(', ')})];
        local next = gfenv()[char(${("next").split('').map(v => v.charCodeAt()).join(', ')})];
        local concat = gfenv()[char(${("table").split('').map(v => v.charCodeAt()).join(', ')})][char(${("concat").split('').map(v => v.charCodeAt()).join(', ')})];
        local assert = gfenv()[char(${("assert").split('').map(v => v.charCodeAt()).join(', ')})];
        local pairs = gfenv()[char(${("pairs").split('').map(v => v.charCodeAt()).join(', ')})];
        local len = string[char(${("len").split('').map(v => v.charCodeAt()).join(', ')})]
        local rawget = gfenv()[char(${("rawget").split('').map(v => v.charCodeAt()).join(', ')})];
        local unpack = gfenv()[char(${("unpack").split('').map(v => v.charCodeAt()).join(', ')})];


        local charactertable = {}
        local basedictdecompress = {}
        for i = 0, 255 do
            local ic, iic = char(i), char(i, 0)
            charactertable[ic] = iic
            basedictdecompress[iic] = ic
        end

        CONST_TABLE["IGNORE:${stringByteIdx}"] = nil;
        CONST_TABLE["IGNORE:${stringCharIdx}"] = nil;
        CONST_TABLE["IGNORE:${stringGmatchIdx}"] = nil;
        local sub = gfenv()[char(${("string").split('').map(v => v.charCodeAt()).join(', ')})][char(${("sub").split('').map(v => v.charCodeAt()).join(', ')})];
        local constMTableIndex = "IGNORE:${mtIdxStr}";
        
        local domath = function(...) return ... end;
        local wordindex = 0;
        local environment = {''}
        
        ${shuffleArray([
            `local getAWord = function(len, str, wordindex, Environment)
                len = len or 1
                local word = Environment["|Stringsub|"](str, wordindex, domath(wordindex, domath(len, 1, "|SUB|"), "|ADD|")) --// wordindex + (len - 1)
                wordindex = domath(wordindex, len, "|ADD|") --// wordindex + len
                return word
            end`,
            `--// generate this one like 1-3 times but randomize the 256
            local getBWord = function(str, wordindex, Environment)
                local left, right = Environment["|Stringbyte|"](str, wordindex, wordindex + 1)
                wordindex = wordindex + 2
                return (right * 256) + left
            end`,
            `--// generate this one 2-3 times and randomize the 65536 and 256
            local getCWord = function(str, wordindex, Environment)
                local left, right, front = Environment["|Stringbyte|"](str, wordindex, wordindex + 2)
                wordindex = wordindex + 3
                return (front * 65536) + (right * 256) + left
            end`,
            `--// generate this one 4-5 times and randomize the numbers
            local getDWord = function(str, wordindex, Environment)
                local left, right, front, bacl = Environment["|Stringbyte|"](str, wordindex, wordindex + 3)
                wordindex = wordindex + 4
                return (back * 16777216) + (front * 65536) + (right * 256) + left;
            end`,
            `--// generate this one 5 times and randomize the numbers
            local getQWord = function(str, wordindex, Environment)
                local left, right, front, back, top = Environment["|Stringbyte|"](str, wordindex, wordindex + 4)
                wordindex = wordindex + 5
                return (back * 16777216) + (front * 65536) + (right * 256) + left
                + (top * 4294967296);
            end`
        ]).join('\n')}

        --nerd
        -- thanks melancholy

        -- // equality, less than, greater than test
        local function check(val, val2, statement)
            assert(statement, "dm this to Herrtt or Melancholy")
            if statement == "|EQ|" then
                return val == val2
            elseif statement == "|LT|" then
                return val < val2
            elseif statement == "|LE|" then
                return val <= val2
            end
        end
        
        -- // maths stuff
        local function domath(val, val2, statement)
            assert(statement, "dm this to Herrtt or Melancholy")
            if check(statement, "|MUL|", "|EQ|") then --// if statement == "|MUL|" then
                return val * val2
            elseif check(statement, "|DIV|", "|EQ|") then --// if statement == "|DIV|" then
                return val / val2
            elseif check(statement, "|ADD|", "|EQ|") then --// if statement == "|ADD|" then
                return val + val2
            elseif check(statement, "|SUB|", "|EQ|") then --// if statement == "|SUB|" then
                return val - val2
            elseif check(statement, "|MOD|", "|EQ|") then --// if statement == "|MOD|" then
                return val % val2
            elseif check(statement, "|POW|", "|EQ|") then --// if statement == "|POW|" then
                return val ^ val2
            end
        end
        
        -- // dont know what to call this tbh
        local function reverser(val, statement)
            assert(statement, "dm this to Herrtt or Melancholy")
            if check(statement, "|UNM|", "|EQ|") then --// if statement == "|UNM|" then
                return -val
            elseif check(statement, "|NOT|", "|EQ|") then --// if statement == "|NOT|" then
                return not val
            elseif check(statement, "|LEN|", "|EQ|") then --// if statement == "|LEN|" then
                return #val
            end
        end
        
        -- // concat stuff
        local function concat(val, val2, statement)
            assert(statement, "dm this to Herrtt or Melancholy")
            if check(statement, "|CONCATSTRING|", "|EQ|") then --// if statement == "|CONCATSTRING|" then
                return val .. val2
            elseif check(statement, "|CONCATTABLE|", "|EQ|") then --// statement == "|CONCATTABLE|" then
                return concat(val, val2)
            end
        end
        

        local chartbl = {}
        local ${shuffleArray([ 'BitXOR', 'XORString', 'XORTable', 'XORString1Fake', 'XORTable1Fake' ]).join(', ')}
        ${createControlFlow(shuffleArray([
            `
            XORString1Fake = function(str, key)
                local res = "IGNORE:";
                local a = 1
                for i = 1,#str do
                    local xored = BitXOR(byte(sub(str, i, i)), byte(sub(key, a,a)) )
                    res = res .. rawget(chartbl, xored) or xored
                    a = a + 1;
                    if a > #key then
                        a = 1
                    end
                end
    
                return res   
            end;
            `,
            `
            XORTable1Fake = function(tabl, key)
                local res = "IGNORE:";
                local a = 1
                for i = 1,#tabl do
                    local xored = BitXOR(tabl[i], byte(sub(key, a,a)) )
                    res = res .. chartbl[xored] or xored
                    a = a + 1;
                    if a > #key then
                        a = 1;
                    end
                end
    
                return res
            end;
            `
            ]))}

        BitXOR = function(a,b) --Bitwise xor
            local p,c=1,0
            while a>0 and b>0 do
                local ra,rb=a%2,b%2
                if ra~=rb then c=c+p end
                a,b,p=(a-ra)/2,(b-rb)/2,p*2
            end
            if a<b then a=b end
            while a>0 do
                local ra=a%2
                if ra>0 then c=c+p end
                a,p=(a-ra)/2,p*2
            end
            return c
        end;

        for i, v in pairs(charactertable) do
            chartbl[byte(i)] = i
        end

        ${createControlFlow(shuffleArray([
        `
        XORString = function(str, key)
            local res = "IGNORE:";
            local a = 1
            for i = 1,#str do
                local xored = BitXOR(byte(sub(str, i, i)), byte(sub(key, a,a)) )
                res = res .. rawget(chartbl, xored) or xored
                a = a + 1;
                if a > #key then
                    a = 1
                end
            end

            return res   
        end;
        `,
        `
        XORTable = function(tabl, key)
            local res = "IGNORE:";
            local a = 1
            for i = 1,#tabl do
                local xored = BitXOR(tabl[i], byte(sub(key, a,a)) )
                res = res .. chartbl[xored] or xored
                a = a + 1;
                if a > #key then
                    a = 1;
                end
            end

            return res
        end;
        `
        ]))}
        
        local NumberTable = { {}, {} }
        local TrackNumberTable = 1
        for i = 1, 255 do
            if i >= 112 then
                NumberTable[2][TrackNumberTable] = i
            TrackNumberTable = TrackNumberTable + 1
            else
                NumberTable[1][i] = i
            end
        end

        local characters = char(unpack(NumberTable[1])) .. char(unpack(NumberTable[2]))

        local ${shuffleArray([ 
            'XORTableSec', 
            'XORStringSec', 
            'xorSecondaryKey', 
            'xorPrimaryKey',
            'XORStringPrim',
            'xorDecodeckey',
            'XORStringPrim1'
        ]).join(', ')};
        xorSecondaryKey = XORTable({${xorStrArr(tree.XORSecondary, ranKey).join(', ')}}, "IGNORE:${toEscStrF(ranKey)}");

        ${createControlFlow(shuffleArray([
            `XORTableSec = function(...)
                return XORTable(..., xorSecondaryKey)
            end;`,
            `XORStringSec = function(a, ...)
                return XORString(a, xorSecondaryKey, ...)
            end;`,
            `XORStringPrim = function(a, ...)
                return XORString(a, xorPrimaryKey, ...)
            end;`
        ]))}

        xorPrimaryKey = XORTable({${xorStrArr(tree.XORPrimary, ranKey).join(', ')}}, "IGNORE:${toEscStrF(ranKey)}");
        xorDecodeckey = XORTable({${xorStrArr(tree.XORDecodeCKey, ranKey).join(', ')}}, "IGNORE:${toEscStrF(ranKey)}");
        local _1 = byte(char(1));
        CONST_TABLE["IGNORE:${xorName}"] = function(str, key)
            local res = char();
            local a = _1;
            for i = _1, #str do
                local xored = BitXOR( byte(sub(str, i, i)), byte(sub(key, a,a)) );
                res = format(("%s%s"), res, rawget(chartbl, xored) or xored);
                a = a + _1;
                a = (a > #key and _1) or a;
            end;
            return res;
        end;
        local xorStrS1 = CONST_TABLE[XORTableSec({${xorStrArr(xorName, tree.XORSecondary)}})];
        \n`

        s += `CONST_TABLE = |ConstantTable|`
        s += `CONST_TABLE["${xorName}"] = xorStrS1;`

        print("adding environment variables")
        let env = shuffleArray([
            "string", "pcall", "error", 
            "table", "setmetatable", "tostring", 
            "tonumber", "print", "type", 
            "unpack", "pairs", "select", 
            "assert", "coroutine", "getmetatable",
            "rawget", "setraw"
            
        ])
        
        s += `\n--START_ENV_LOAD\n`
        for (n of env) {
            let xored = `{${xorStrArr(n, tree.XORSecondary).join(', ')}}`
            s += `local ${n} = gfenv()[XORTableSec(${xored})];\n`
        }
        s += `local xorStr = CONST_TABLE["IGNORE:${toEscStrF(xorName)}"];`
        s+= `\n--END_ENV_LOAD\n`

        s += `local cyield = coroutine["yield"];`

        print("adding error handling")
        s += `\nlocal function whatLineErr(...)
    local _, str = ...
    local Matched = gmatch(tostring(str), ':(%d*):')()
    return tonumber(Matched)
end;

local StartLine = whatLineErr(pcall(function() local a = "a" ^ 1 end));`    


        s += `\nlocal print = print;`

        s += `\nlocal function _Returns(...)
    return select('#', ...), {...};
end;`

        print("creating start of wrapper")
        s += `\n

        local |INST_LOAD_VAR| = |INST_LOAD_SRC|;
        

        if (CONST_TABLE[constMTableIndex] == nil) then
            return (function()
                while print ~= gfenv do
                    WATERMARK = sub(WATERMARK, 1, #WATERMARK - 1) .. '${Math.random() * 10}';
                end
            end)()
        end;

        -- // integrity check character table
        local function integritycheckchartbl()
            if reverser(check(getmetatable(chartbl), nil, "|EQ|"), "|NOT|") then -- // if getmetatable(chartable) ~= nil then
                return cyield()
            end
        end

        local function new(signature, size_or_C, chunk_or_upvals, env, uvals)
            ${(() => {
                let a = [
                    "local Chunk;",
                    "local current;",
                    "local last;",
                    "local ran;",
                    "local InstLen;",
                    "local ConstLen;",
                    "local ProtoLen;",
                    "local Env;",
                    "local size_constinst;",
                    "local Lupvals;",
                    "local Upvalues;",
                    "local isClosure = false;",
                    "for _ in integritycheckchartbl do break end;"
                ]

                let r = Math.floor((Math.random() * 5) + 2)
                for (let i = 0; i < r; i++)
                    a.push(`local x${genString(9)} = "${genString(Math.floor(Math.random() * 10))}";`)

                return shuffleArray(a).join('\n')
            })()}

            if ((signature ~= 0 and size_or_C ~= "|OP_CLOSURE|") and signature ~= "|Signature|") then
                while (signature ~= 0) do
                    size_or_C = '${genString(Math.floor(Math.random() * 16))}';
                end;
            elseif (signature == 0 and size_or_C == "|OP_CLOSURE|") then
                isClosure = true;
            end;

            local ctable = {}
            for i = 1, domath(64, 4, '|MUL|') do
                ctable[i] = char(domath(i, 1, '|SUB|'))
            end

            local XORString1
            local xorPrimaryKey1 = (function(a, ...) 
                return a and xorPrimaryKey
            end)("${genString(10)}")
            local res = concat('', char(), '|CONCATSTRING|');
            ${createControlFlow(["Chunk = isClosure and (chunk_or_upvals) or ({});"])}
            ${createControlFlow(shuffleArray([
                "ran = false;",
                "Env = (isClosure == true and env) or (isClosure == false and uvals or gfenv()) or {};",
                "size_constinst = isClosure and ({}) or (size_or_C)",
                `Chunk['|T_UPVALS|'] = isClosure and (Chunk['|T_UPVALS|']) or (chunk_or_upvals);`,
                "Lupvals = {}",
                "InstLen = isClosure and (Chunk['|Inst|'][-1]) or (1);",
                "ConstLen = isClosure and (Chunk['|Const|'][-1]) or (0);",
                "ProtoLen = (0);",
                "Upvalues = isClosure and uvals;"
            ]))}

            ${createControlFlow([
                `XORString1 = function(str, key)
                    local res1 = res
                    local a = reverser(-1, '|UNM|')
                    for i = 1, len(str) do
                        local xored = BitXOR(byte(sub(str, i, i)), byte(sub(key, a,a)) )
                        res1 = concat(res1, sub(characters, xored, xored) or xored, '|CONCATSTRING|');
                        a = check(len(key), a + 1, '|LT|') and 1 or domath(a, 1, '|ADD|');
                    end

                    return res1
                end;`,
                `XORStringPrim1 = function(a, ...)
                    return XORString1(a, xorPrimaryKey1, ...);
                end;`
            ])}
            

            local Metamethods_ = {`

        
            print("creating metamethods")
        let Metamethods = [
`\n["__index"] = function(self, index)
    if (isClosure ~= true and ran) then
        ${createControlFlow([
            " while (1 == 1 and ran == (#Chunk > -1)) do Chunk[index] = '\\0' end;",
            "return;",
        ])}
    elseif (Chunk == nil) then
        Chunk = {}
    end;

    ${createControlFlow(shuffleArray([
        "if (index == '__instr__') then current = index; end;",
        "if (index == '__const__') then current = index; end;",
        "if (index == '__proto__') then current = index; end;",
        "if (index == '__init__') then current = index; end;",
    ]))}

    if (index ~= '__instr__' and index ~= '__const__' and index ~= '__init__' and index ~= '__proto__') then
        ${createControlFlow([
            "return error('invalid index!');"
        ])}
    end
    return self
end;`,

`\n["__call"] = function(self, arg, A, B, C, D)
if (isClosure ~= true and ran) then
    return error('Already ran (1)!')
end
if (current == '__instr__') then
    if (last) then
        ${createControlFlow([
            `
            local Inst = { ['|Opcode|'] = last };
            ${createControlFlow(shuffleArray([
                "|A| = arg[1];",
                "|B| = arg[2];",
                "|C| = arg[3];",
                "Inst['SUPER_OP'] = false;",
                "Chunk['|Inst|'][InstLen] = Inst;"
            ]))}
            `,
            "InstLen = InstLen + 1;",
            "last = nil;",
        ])}
    else
        ${createControlFlow([
            "last = arg",
        ])}
    end
elseif (current == '__const__') then
    local IDX;
    ${createControlFlow([
        "IDX = Chunk['|Const|'][ConstLen - 1];",
    ])}
    if (arg == nil and type(IDX) == "string") then
        ${createControlFlow([
            "Chunk['|Const|'][ConstLen - 1] = { XORStringSec(IDX) };",
        ])}
    elseif (type(arg) == "table" and arg["${ranKey2}"] == true) then
        ${createControlFlow([
            "Chunk['|Const|'][ConstLen] = arg;",
            "ConstLen = ConstLen + 1;",
        ])}
    elseif (type(arg) == "table") then
        ${createControlFlow([
            "Chunk['|Const|'][ConstLen] = arg[1] or nil;",
            "ConstLen = ConstLen + 1;",
        ])}
    else
        ${createControlFlow([
            "Chunk['|Const|'][ConstLen] = arg;",
            "ConstLen = ConstLen + 1;",
        ])}
    end
elseif (current == '__proto__') then
    local fix;
    fix = function(whatfix)
        local const = {};
        local constL = 0;
        for i = 1, #whatfix["|Const|"] do
            local v = whatfix["|Const|"][i]
            if (type(v) == "table") then
                integritycheckchartbl()
                const[constL] = {
                    XORStringSec(v[1])
                };
                constL = constL + 1
            else
                const[constL] = v
                constL = constL + 1
            end;
        end;
        const[-1] = constL
        whatfix['|Const|'] = const;
        --
        local inst = {};
        local instL = 1;
        for i = 1, #whatfix["|Inst|"] do
            local v = whatfix["|Inst|"][i]
            inst[instL] = v
            instL = instL + 1
        end
        inst[-1] = instL
        whatfix['|Inst|'] = inst
        --
        local proto = {};
        local protoL = 0;
        for i = 1, #whatfix["|Proto|"] do
            proto[protoL] = fix(whatfix["|Proto|"][i])
            protoL = protoL + 1
        end
        whatfix["|Proto|"] = proto
        whatfix["|Proto|"][-1] = protoL

        return whatfix
    end
    local arg1 = fix(arg)
    Chunk["|Proto|"][ProtoLen] = arg1;
    ProtoLen = ProtoLen + 1;
elseif (current == '__init__') then
    while (arg > -1) do
        Chunk[A] = Chunk[A] or {};
        Chunk[B] = Chunk[B] or {};
        Chunk[C] = Chunk[C] or {};
        Chunk['|Args|'] = Chunk['|Args|'] or D;
        arg = (arg * -1) - (50);
    end
end
return self;
end;`
            ]

        print("adding metamethods")
        Metamethods = shuffleArray(Metamethods)
        s += Metamethods[0]
        s += Metamethods[1]

        
        s += `};`
        
        print("creating main loop")
        let runStr = `local function Run(_, ...)
        if (isClosure ~= true and ran) then
            return error('Already ran (2)!')
        else
            ran = true
        end
        
        --[[if (isClosure ~= true and (size_constinst[1] ~= ConstLen)) then
            return
        elseif (isClosure ~= true and (size_constinst[2] ~= (InstLen - 1))) then
            return
        end--]]
        
        local pc, Top = 1, -1
        local GStack = {}
        local Stack = setmetatable({}, {
            ["__index"] = GStack,
            ["__newindex"] = function(_, Key, Value)
                if (Key > Top) then
                    Top = Key;
                end;
                GStack[Key] = Value;
            end;
        });
        
        local Vararg, Varargsz = {}, gfenv()["select"]('#', ...) - 1;
        local Args = {...};
        
        for Idx = 0, Varargsz do
            if (Idx >= Chunk['|Args|']) then
                Vararg[Idx - Chunk['|Args|']] = Args[Idx + 1];
            else
                Stack[Idx] = Args[Idx + 1];
            end;
        end;
        
        local function Loop()
            local ChunkConst = Chunk['|Const|'];
            while true do
                local ${shuffleArray([
                    "Inst", "OP_CODE", "a", "b", "c"
                ]).join(', ')};
                Inst = Chunk['|Inst|'][pc];
                ${shuffleArray([
                    "OP_CODE = Inst['|Opcode|'];",
                    //"a = |A|;",
                    //"b = |B|;",
                    //"c = |C| or nil;",
                    "pc = pc + 1"
                ]).join('\n')}
  
                -- fat trash debug
                local t = tostring;
                --print(("IGNORE:[%s]\t%s\t|\t%s\t:\t%s\t:\t%s"):format(t(pc - 1), t(enum), t(a), t(b), t(c)));
        `
                
                print("creating fake opcodes")
                let fakeOpcodes = settings.Debug === true ? 0 : Math.floor((Object.keys(tree.Chunk.UsedInstructions).length + 2) / 1.2)
                let fakeLines = [
                    // Xor shit
                    "Stack[|A|] = xorStr(Chunk['|Const|'][|B|], xorPrimaryKey);",
                    "Chunk['|Const|'][i] = xorStr(v[1], xorPrimaryKey)",
                    "for i,v in pairs(Chunk['|Const|']) do if (type(v) == 'table' and type(v[1]) == 'string') then Chunk['|Const|'][i] = xorStr(v[1], xorPrimaryKey) end end;",
                    "Stack[|A|] = Env[XORStringPrim(Chunk['|Const|'][|B|])];",
                    "Stack[|A|] = XORStringPrim(Chunk['|Const|'][|B|]);",
                    "Env[XORStringPrim(Chunk['|Const|'][|B|])] = Stack[|A|];",

                    // Really shit shit
                    "Inst[5] = Chunk['|Const|'][Inst[5]];",
                    "local Upvalues = Chunk['|Const|'][|A| + |C|]; Stack[|A|]	= Upvalues[|B|];",
                    "Stack[|A|] = Env[Chunk['|Const|'][|B|]](|INST_LOAD_VAR|);",
                    "Env[Chunk['|Const|'][|B|]]	= Stack[|A|];",
                    "Stack[|A|]	= { sub((|INST_LOAD_VAR|), 1, Stack[|B|]) };",
                    "_Returns(Stack[|A|](unpack(args, 1, limit - |A|, (|INST_LOAD_VAR|))));",
                    "do return Stack[|C|] end",
                    "for i = Stack[|B|], Stack[|A|] do Stack[|C|] = Stack[|C|] .. Stack[Chunk['|Const|']][i] end;",
                    "if (_Returns(Stack[|A|]) == |INST_LOAD_VAR|) then Chunk['|Opcode|'] = (function(a) return a ^ '__const__' end)('__init__'); end; do InstrPoint = InstrPoint + 1 end",
                    "InstrPoint = InstrPoint - 1;",
                    "local Stk = Stack;local B = |B|;local K = Stk[B];for Idx = B + 1, |C| do K = K .. Stk[Idx]; end;Stack[|A|] = K; Stack[|B|] = |INST_LOAD_VAR|;",
                    "Stack = |B| % Stack[|B|] * |A|;",
                    "InstrPoint = InstrPoint - 1 * (Chunk['|Inst|']); Chunk['|Opcode|']((function(a) return a ^ '__const__' end)('__init__'));",
                    "Chunk['|Const|'] = |B| / { [|A|] = '__value__', [|C|] = |INST_LOAD_VAR| };",
                    "|INST_LOAD_VAR| = sub(Chunk[Stack[|A|]], Stack[|B|], Stack[|C|])"
        
                ]
                

                let fastFakeLines = [ ]

                let fakeCode = []
                for (let i = 0; i < 20; i++) {
                    let s = []
                    let f = Math.floor(Math.random() * 9 + 5)
                    for (let i = 0; i < f; i += 2) {
                        s.push(`\n${shuffleArray(fakeLines)[0]}`)
                    }
                    let f2 = Math.floor(Math.random() * 9 + 3)
                    if (fastFakeLines[0] !== null && fastFakeLines[0] !== undefined)
                        for (let i = 0; i < f2; i += 2)
                            s.push(`\n${shuffleArray(fastFakeLines)[0]}`)
                    fakeCode.push(s.join('\n'))//settings.Debug === true ? s.join('\n') : createControlFlow(s))
                }
        
                print("finiding used instructions")
                let usedOpcodes = []
                for (let opcode in tree.Chunk.UsedInstructions) {
                    usedOpcodes.push( tree.Opmap[isFinite(opcode) ? parseInt(opcode, 10) : opcode ])
                }

                //console.log("AY:", tree.Chunk.Virtuals)
                for (let virtual of tree.Chunk.Virtuals) {
                    usedOpcodes.push(virtual)
                }
        
                print("adding fake opcodes to opmap")
                for (let i = 0; i < fakeOpcodes; i++) {
                    usedOpcodes.push({
                        fake: true,
                        name: `${genUniString(12)}`
                    })
                }
                usedOpcodes = shuffleArray(usedOpcodes)
    
                print("creating logic and control flow for main loop")
                runStr += CreateOpcodeStat(usedOpcodes, fakeCode, tree, settings.Debug)
                runStr += `\nif (pc > (InstLen - 1)) then
                        break
                    end
                end
            end
            local Result1, Result2 = Loop()
            if Result1 and (Result2 > 0) then
                return unpack(Result1, 1, Result2)
            end
    
            return
        end;`;

        s += runStr;

        s += `\nreturn setmetatable({}, Metamethods_), Run\nend;`

        print("adding end of wrapper")
        s += `
local VM, Wrapper = new("${tree.Headers.Signature}", {${tree.Chunk.Const.length}, ${tree.Chunk.Instr.length}}, ${tree.Chunk.Upvals}, gfenv());
VM.__init__(0, '|Const|', '|Inst|', '|Proto|', ${tree.Chunk.Args})
        `


        print("adding btcode deserializer")
        


        s += ``
        //createControlFlow([ ])


        print("creating used constants")
        let cnstLoadCode = [ ` local _CONST = VM["__const__"];` ]
        for (let idx in tree.Chunk.Const) {
            let cnst = tree.Chunk.Const[idx]
            let code = ''
            //console.log(typeof cnst, cnst.constructor === Array, cnst)
            if (typeof cnst === 'object' && cnst !== null && cnst.Encrypted == true && (cnst.Type !== null && cnst.Type !== undefined)) {
                if (cnst.Type === 'number')
                    code += ` VM({${cnst.Orig}});\n`;
                else
                    code += ` VM("IGNORE:${toEscStr( xorStrArr( cnst.Data, tree.XORSecondary ) )}")();\n`;
            } else if(typeof cnst === 'object' && cnst !== null && cnst !== undefined && cnst.constructor === Array) {
                code += ` VM("IGNORE:${toEscStr(cnst)}");\n`;
            } else if(typeof cnst === 'number') {
                code += ` VM({${cnst}});\n`;
            } else if(typeof cnst === 'boolean') {
                code += ` VM(${cnst.toString()});`
            } else if(typeof cnst === 'string') {
                code += ` VM('IGNORE:${toEscStrF(cnst)}');\n`
            } else if(cnst === null) {
                code += ` VM({nil});\n`
            } else {
                code += ` VM('IGNORE:${cnst}');\n`
            }
            cnstLoadCode.push(code)
        }

        print("creating used instructions")
        let [ instLoad_Code, inst_loadSrc ] = CreateInstDecoder(tree.Chunk, tree, settings)
        let instrLoadCode = [
            instLoad_Code
        ]

        print("creating used protos")
        let protoLoadCode = [ ` local _PROTO = VM["__proto__"];`]
        let getProtoLoadCode
        getProtoLoadCode = function(proto) {
            let consts = []
            for (let idx in proto.Const) {
                let cnst = proto.Const[idx]
                //console.log(typeof cnst, cnst.constructor, cnst)
                if (typeof cnst === 'object' && cnst !== null && cnst.Encrypted === true && (cnst.Type !== null && cnst.Type !== null && cnst.Type !== undefined)) {
                    if (cnst.Type === 'number')
                        consts.push(`${cnst.Orig}`);
                    else
                        consts.push(`{"IGNORE:${toEscStr( xorStrArr( cnst.Data, tree.XORSecondary ) )}"}`);
                } else if(typeof cnst === 'object' && cnst !== null && cnst !== undefined && cnst.constructor === Array) {
                    consts.push(`"IGNORE:${toEscStr(cnst)}"`);
                } else if(typeof cnst === 'number') {
                    consts.push(`${cnst}`);
                } else if(typeof cnst === 'boolean') {
                    consts.push(`${cnst}`);
                } else if(cnst === null || cnst === undefined) {
                    consts.push(`nil`);
                } else if(typeof cnst === 'string') {
                    consts.push(`'IGNORE:${toEscStrF( cnst )}'`);
                } else {
                    consts.push(`'${cnst}'`);
                }
            }

            let instructs = []
            for (let idx in proto.Instr) {
                let inst = proto.Instr[idx]
                instructs.push(`{ ['|Opcode|'] = "${inst.Enum}", ${inst['1'] !== null ? inst['1'] : 0}, ${inst['2'] !== null ? inst['2'] : 0}, ${inst['3'] !== null ? `${inst['3']} ,` : ''} ["__value__"] = ${inst.Value} }`)
            }

            let protos = []
            for (let idx in proto.Proto) {
                let pr = proto.Proto[idx]
                protos.push(getProtoLoadCode(pr))
            }

            return `{
                ["|Const|"] = { ${consts.join(',\n')} },
                ["|Inst|"] = { ${instructs.join(',\n')} },
                ["|Proto|"] = { ${protos.join(';\n')} },
                ["|T_UPVALS|"] = ${proto.Upvals},
                ["|Args|"] = ${proto.Args}
            }`
        }


        for (let idx in tree.Chunk.Proto) {
            let proto = tree.Chunk.Proto[idx]
            let str = getProtoLoadCode(proto)
            protoLoadCode.push(`VM (${str})`)
        }

        print("adding consts, insts, & protos")
        let cnstLoadSrc = cnstLoadCode.join('\n')/* settings.Debug === true ? cnstLoadCode.join('\n') : (() => {
            let str = ''
            while (cnstLoadCode.length !== 0) {
                let co = []
                for (let i = 0; i < 50; i++) {
                    let s = cnstLoadCode.shift()
                    if (s != null) {
                        co.push( s )
                    } else {
                        break
                    }
                }
                str += `\ndo\n${createControlFlow(co)}\nend;`
            }
            return str
        })();/**/
        cnstLoadSrc = `\ndo\n${cnstLoadSrc}\nend;`
        let instrLoadSrc = instrLoadCode.join('\n')/* settings.Debug === true ? instrLoadCode.join('\n') :(() => {
            let str = ''
            while (instrLoadCode.length !== 0) {
                let co = []
                for (let i = 0; i < 100; i++) {
                    let s = instrLoadCode.shift()
                    if (s != null) {
                        co.push( s )
                    } else {
                        break
                    }
                }
                str += `\ndo\n${createControlFlow(co)}\nend;`
            }
            return str
        })();/**/
        instrLoadSrc = `\ndo\n${instrLoadSrc}\nend;`
        let protoLoadSrc = protoLoadCode.join('\n')/* settings.Debug === true ? protoLoadCode.join('\n') : (() => {
            let str = ''
            while (protoLoadCode.length !== 0) {
                let co = []
                for (let i = 0; i < 100; i++) {
                    let s = protoLoadCode.shift()
                    if (s != null) {
                        co.push( s )
                    } else {
                        break
                    }
                }
                str += `\ndo\n${createControlFlow(co)}\nend;`
            }
            return str
        })();/**/
        protoLoadSrc = `\ndo\n${protoLoadSrc}\nend;`

        if (Math.random() > 0.5) {
            s += cnstLoadSrc
            s += instrLoadSrc
            s += protoLoadSrc
        } else {
            s += instrLoadSrc
            s += cnstLoadSrc
            s += protoLoadSrc
        }

        print("adding end of obfuscator")
        s += `\nreturn Wrapper(gfenv());` // Run vm

        let amountOfArgs = Math.floor((Math.random() * 25) + 20);
        s = `${watermarkStart}\nreturn (function(__ARG__) 
            local ${shuffleArray([ 'Environment', 'watermark', 'amountOfArgs' ]).join(', ')};
            amountOfArgs = (amountOfArgs or 0);
            for i,v in pairs(__ARG__) do
                amountOfArgs = (amountOfArgs or 0) + 1
            end

            if (amountOfArgs < 2) then
                return ("IGNORE:${genString(Math.floor(Math.random() * 20))}")
            end

            ${createControlFlow(shuffleArray([
                'Environment = __ARG__[1];',
                'watermark = __ARG__[2];'
            ]))}
            ${s}
        end)({
            ${(() => {
                let a = [
                    '[1] = gfenv();',
                    '[2] = WATERMARK;',
                ]
                for (let i = 0; i < (amountOfArgs / 3); i++)
                    a.push(`["IGNORE:${genString(Math.floor((Math.random() * 30) + 2))}"] = "IGNORE:${genString(Math.floor((Math.random() * 20) + 8))}";`)
                for (let i = 0; i < (amountOfArgs / 3); i++)
                    a.push(`[${Math.random() * 400 + 10}] = "IGNORE:${genString(Math.floor((Math.random() * 20) + 8))}";`)
                for (let i = 0; i < (amountOfArgs / 3); i++)
                    a.push(`[${Math.random() * 250 + -300}] = "IGNORE:${genString(Math.floor((Math.random() * 20) + 8))}";`)
                

                return shuffleArray(a).join('\n')
            })()}
        });\n`

        print("replacing dynamic variables")

        //s = s.split('|BYTECODE|').join(BytecodeLib.Encoder.dump_tree(tree))
        s = s.split('|INST_LOAD_VAR|').join(settings.Debug === true ? '__instLoadVar__' : genUniString())
        s = s.split('|INST_LOAD_SRC|').join(`"IGNORE:${inst_loadSrc}"`)

        let instIdx = [ ]
        for (let i = 0; i < 3; i++) {
            let a
            do {
                a = (Math.random() * 10000) // Math.floor
            } while (instIdx.includes(a))
            instIdx.push(i + 1)//a)
        }

        s = s.split('|A|').join(`Inst[${instIdx[0]}]`)
        s = s.split('|B|').join(`Inst[${instIdx[1]}]`)
        s = s.split('|C|').join(`Inst[${instIdx[2]}]`)
        s = s.split('|Bx|').join(`Inst[${instIdx[1]}]`)
        s = s.split('|sBx|').join(`Inst[${instIdx[1]}]`)

        s = s.split('|AIdx|').join(`${instIdx[0]}`)
        s = s.split('|BIdx|').join(`${instIdx[1]}`)
        s = s.split('|CIdx|').join(`${instIdx[2]}`)
        s = s.split('|BxIdx|').join(`${instIdx[1]}`)
        s = s.split('|sBxIdx|').join(`${instIdx[1]}`)
        // |OP_MOVE|
        // |OP_GETUPVAL|
        s = s.split('|OP_MOVE|').join(tree.Opmap[opdata.Opnames.indexOf('MOVE')])
        s = s.split('|OP_GETUPVAL|').join(tree.Opmap[opdata.Opnames.indexOf('GETUPVAL')])
        s = s.split('|OP_CLOSURE|').join(tree.Opmap[opdata.Opnames.indexOf('CLOSURE')])


        s = s.split('|Inst|').join(settings.Debug === true ? 'inst' : genUniString())
        s = s.split('|Opcode|').join(settings.Debug === true ? 'opcode' : genUniString())
        s = s.split('|Const|').join(settings.Debug === true ? 'const' : genUniString())
        s = s.split('|Proto|').join(settings.Debug === true ? 'proto' : genUniString())
        s = s.split('__instr__').join(settings.Debug === true ? '__instr__' : genUniString())
        s = s.split('__const__').join(settings.Debug === true ? '__const__' : genUniString())
        s = s.split('__init__').join(settings.Debug === true ? '__init__' : genUniString())
        s = s.split('__value__').join(settings.Debug === true ? '__value__' : genUniString())
        s = s.split('|Enum|').join(settings.Debug === true ? 'enum' : genUniString())
        s = s.split('|Value|').join(settings.Debug === true ? 'value' : genUniString())
        s = s.split('|T_UPVALS|').join(settings.Debug === true ? 't_upvals' : genUniString())
        s = s.split('|Args|').join(settings.Debug === true ? 'args' : genUniString())
        
        s = s.split('InstrPoint').join('pc')

        s = s.split('|Signature|').join(tree.Headers.Signature)
        s = s.split('|Watermark|').join(settings.Watermark)
        s = s.split('|Base_64_Str|').join(tree.B64Key)
        s = s.split('OP_CODE').join('enum')

        s = s.split('|WatermarkXORTable|').join(`{${xorStrArr(settings.Watermark, tree.XORSecondary).join(', ')}}`)
        s = s.split('|WatermarkXORString|').join(`"IGNORE:${toEscStr(xorStrArr(settings.Watermark, tree.XORSecondary))}"`)
    

        let replaceWords = {
            'Stringbyte': settings.Debug === true ? 'Stringbyte' : genUniString(),
            'Stringsub': settings.Debug === true ? 'Stringsub' : genUniString(),

            'ADD': settings.Debug === true ? 'ADD' : genUniString(),
            'SUB': settings.Debug === true ? 'SUB' : genUniString(),
            'MUL': settings.Debug === true ? 'MUL' : genUniString(),
            'DIV': settings.Debug === true ? 'DIV' : genUniString(),
            'MOD': settings.Debug === true ? 'MOD' : genUniString(),
            'POW': settings.Debug === true ? 'POW' : genUniString(),

            'EQ': settings.Debug === true ? 'EQ' : genUniString(),
            'LT': settings.Debug === true ? 'LT' : genUniString(),
            'LE': settings.Debug === true ? 'LE' : genUniString(),

            'UNM': settings.Debug === true ? 'UNM' : genUniString(),
            'NOT': settings.Debug === true ? 'NOT' : genUniString(),
            'LEN': settings.Debug === true ? 'LEN' : genUniString(),

            'CONCATSTRING': settings.Debug === true ? 'CONCATSTRING' : genUniString(),
            'CONCATTABLE': settings.Debug === true ? 'CONCATTABLE' : genUniString()
        }

        for (let a of Object.entries(replaceWords)) {
            //s = s.split(`|${a[0]}|`).join(a[1])
            //console.log(a)
        }


        // Replace all strings
        let tableStr = ``
        if (settings.CreateConstTable !== false) {
            print("replacing strings and adding to index table")
            let indexes = { }
            let arr = []
            s = settings.Debug === true ? s : s.replace(/['"]([\W\w]*?)['"]/gm, (x) => {
                if (x.match(/^["']IGNORE:/) !== null)
                    return x;

                let name = indexes[x]
                if (name === undefined || name === null) {
                    do {
                        name = `_${genString(Math.floor(Math.random() * 11) + 5)}`
                    } while (indexes[name] != undefined)
                    indexes[x] = name
                    //let delimiter = x.substr(0, 1)
                    let text = x.substr(1, x.length - 2)
                    
                    arr.push(
                        `CONST_TABLE[XORStringSec("${toEscStr(xorStrArr(name, tree.XORSecondary))}")] = XORString("${toEscStr(xorStrArr(text, tree.XORSecondary))}", xorSecondaryKey);`
                    )
                }

                return `(CONST_TABLE.${name})`
            })

            s = s.split('IGNORE:').join('')

            print("adding strings to const table")
            //let arr = []
            /*for (let name in indexes) {
                let obj = indexes[name]
                arr.push(
                    `CONST_TABLE[XORStringSec("${toEscStr(xorStrArr(name, tree.XORSecondary))}")] = XORString("${toEscStr(xorStrArr(text, tree.XORSecondary))}", xorSecondaryKey);`
                )
            }*/
            arr = shuffleArray(arr)


            print("creating constant table")
            print("ctablesize: " + arr.length)
            while (arr.length !== 0) {
                let co = []
                for (let i = 0; i < 5000; i++) {
                    let s = arr.shift()
                    if (s != null) {
                        co.push( s )
                    } else {
                        break
                    }
                }
                tableStr += `\ndo\n${true ? co.join('\n') :  createControlFlow(co)}\nend;`
            }

            tableStr = `
            do
                local setmetatable = gfenv()[XORStringSec("${toEscStr(xorStrArr('setmetatable', tree.XORSecondary))}")];
                if (setmetatable ~= nil) then -- just incase they got some shit lua version
                    CONST_TABLE[XORStringSec("${toEscStr(xorStrArr(mtIdxStr, tree.XORSecondary))}")] = setmetatable({
                        ${(function() {
                            let a = []
                            let l = Math.floor(Math.random() * 5) + 2
                            for (let i = 0; i < l; i++) {
                                a.push(`[${Math.random() * 500 + -250}] = ${Math.random() * 200 + -100};`)
                            }
                            return a.join('\n')
                        })()}
                    }, {
                        [XORStringSec("${toEscStr(xorStrArr('__tostring', tree.XORSecondary))}")] = function(a, b)
                            return (function()
                                while true do
                                    CONST_TABLE = CONST_TABLE or nil;
                                    if (CONST_TABLE ~= nil and CONST_TABLE[1] ~= nil) then
                                        break
                                    else
                                        CONST_TABLE["${toEscStrF(genString(Math.floor(Math.random() * 15) + 10))}"] = "${toEscStrF(genString(Math.floor(Math.random() * 15) + 10))}";
                                    end
                                end;
                                
                                return "${toEscStrF(genString(Math.floor(Math.random() * 30) + 15))}";
                            end)();
                        end;
                    });
                    CONST_TABLE[1] = CONST_TABLE[constMTableIndex];
                end;
                ${tableStr}
            end;`
        } else {
            s = s.split('IGNORE:').join('')
        }
        s = s.split('|ConstantTable|').join(`{ };${tableStr}`)
        print("returning generated code")

        return s
    }
}


-- /src/Generator/controlFlow.js - Control flow obfuscation

// Gotta add

module.exports = {
    CreateControlFlow: function() {

    }
}


-- /src/Generator/rewrite.js - Code rewriting

// generator.js - herrtt
// generates the final script (does not minify tho)


module.exports = {
    Generate: async function(tree, settings) {
    
    
    }
}
 

-- /src/Generator/utils.js - Generator utilities


// there is nothing for this one no need to add it and its very useles


-- /src/Macros/index.js - Macro processing

function visitChunk(chunk, opmap, settings = {}) {
    // Visit opcodes
    for (let Idx = 0; Idx < chunk.Instr.length; Idx++) {
        let inst = chunk.Instr[Idx]
        //console.log(inst)
        if (inst.Name === 'GETGLOBAL' && chunk.Instr[Idx + 1].Name === 'CALL') {
            Idx++
            let A = inst['1']


            //console.log(chunk.Const[inst['2']])
            let macro = chunk.Const[inst['2']]
            switch (macro) {
                case 'HF_TEST':

                    chunk.Tree.Chunk.UsedInstructions[macro] = true
                    if (chunk.Tree.OpQueue == undefined) 
                        chunk.Tree.OpQueue = []
    
                    chunk.Tree.OpQueue.push(macro)
                    inst.Enum = macro
                    inst.Name = macro
                    inst.Type = 'ABx'
                    inst.IsMacro = true
                    inst['1'] = A
                    inst['2'] = 0
                    inst['3'] = null
                    
                    // Remove the call?
                    chunk.Instr.splice(Idx, 1, null)

                    break
                case 'HF_GETSTACK':

                    chunk.Tree.Chunk.UsedInstructions[macro] = true
                    if (chunk.Tree.OpQueue == undefined) 
                        chunk.Tree.OpQueue = []
    
                    chunk.Tree.OpQueue.push(macro)
                    inst.Enum = macro
                    inst.Name = macro
                    inst.Type = 'ABx'
                    inst.IsMacro = true
                    inst['1'] = A
                    inst['2'] = 0
                    inst['3'] = null
                    
                    // Remove the call?
                    chunk.Instr.splice(Idx, 1, null)

                    break
                case 'HF_CRASH':

                    chunk.Tree.Chunk.UsedInstructions[macro] = true
                    if (chunk.Tree.OpQueue == undefined) 
                        chunk.Tree.OpQueue = []
    
                    chunk.Tree.OpQueue.push(macro)
                    inst.Enum = macro
                    inst.Name = macro
                    inst.IsMacro = true
                    inst.Type = 'ABx'
                    inst['1'] = A
                    inst['2'] = 0
                    inst['3'] = null
                    
                    // Remove the call?
                    chunk.Instr.splice(Idx, 1, null)

                    break
                default: break;
            }
        }
    }

    for (let Idx = 0; Idx < chunk.Proto.length; Idx++) {
        visitChunk(chunk.Proto[Idx], opmap, settings)
    }
}

module.exports = {
    Visit: (tree, settings) => {
        visitChunk(tree.Chunk, settings)
    }
}


-- /src/Obfuscator/index.js - Main obfuscation logic



let opdata = require('../Bytecode/opdata.json')
let _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
// ?!@#$%&{}[]()§´^*'¨:.,;-_<abcdefghijklmnopqrstuvwxyz0123456789+/
// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
function shuffleString(str) {
    var a = str.split(""),
        n = a.length;

    for(var i = n - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
    return a.join("");
}

function shuffleArray(array) {
    var currentIndex = array.length,  randomIndex;
  
    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
  
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
  
      // And swap it with the current element.
      [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
  
    return array;
}


function genChars(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    result += characters.charAt(Math.floor(Math.random() * characters.length - 10));
    length--;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}


function xorStrArr(bytes, key) {
    let result = [];
    let j = 0;
    for (let i = 0; i < bytes.length; ++i) {
      result[i] = (typeof(bytes[i]) == 'string'
      	? bytes[i].charCodeAt() : bytes[i]) ^ key.charCodeAt(j);
      ++j;
      if (j >= key.length) {
        j = 0;
      }
    }
    return result;
}

function generateString(length) {
    var result           = '';
    var characters       = '_oOxXuUwWiI0123456789';
    var charactersLength = characters.length;
    result += characters.charAt(Math.floor(Math.random() * characters.length - 10));
    length--;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}

function scrambleOpcodes() {
    let scrabmled = {}
    let taken = {}
    for (let Idx = 0; Idx < opdata.Opnames.length; Idx++) {
        let A
        do {
            A = `x${genChars(1)}${generateString(10)}`
        } while (taken[A])
        taken[A] = Idx
        scrabmled[Idx] = A
    }

    return [ scrabmled, taken ]
}

class SuperOperator {
    constructor(ip = 0) {
        this.InstrPoint = ip
        this.Instructions = []
        this.Virtuals = []
        this.Name = ''
    }
}

function generateSuperOperators(chunk, settings) {

    let ignoredInstructions = []
    let superOperators = []
    function ProcessInstr(ip = 0) {
        let virtual = new SuperOperator(ip)
        superOperators.push(virtual)

        while (ip < (chunk.Instr.length - 1)) {
            let inst = chunk.Instr[ip]
            if (ignoredInstructions.includes(inst)) {
                if (virtual.Instructions.length < 5) { 
                    superOperators.slice(superOperators.indexOf(virtual), 1) 
                }

                while ((ip + 1) < chunk.Instr.length) {
                    ip++
                    if (!ignoredInstructions.includes(chunk.Instr[ip])) {
                        break
                    }
                }
                if ((ip + 2) < chunk.Instr.length) {
                    ProcessInstr(ip)
                }
                
                break
            }

            virtual.Instructions.push(inst)
            ip++
            if (ip >= (chunk.Instr.length - 1))
                break
            if (virtual.Instructions.length >= 5) {
                ProcessInstr(ip)
                break
            }
        }
    }
    
    let instrPoint = 0
    while (instrPoint < (chunk.Instr.length - 1)) {
        let inst = chunk.Instr[instrPoint]
        if (inst !== null) {
            console.log("->", inst.Name, inst['1'], inst['2'], inst['3'], chunk.Const[inst['2']])
            switch (inst.Name) {
                case 'CLOSURE':
                case 'EQ':
                case 'LT':
                case 'LE':
                case 'TEST':
                case 'TESTSET':
                case 'TFORLOOP':
                case 'SETLIST':
                case 'LOADBOOL':
                case 'LOADTRUE':
                case 'LOADFALSE':
                    if (inst['3'] !== 0) {
                        ignoredInstructions.push(inst)
                    }
                    break
                case 'FORLOOP':
                case 'FORPREP':
                case 'JMP':
                    ignoredInstructions.push(inst)
                    ignoredInstructions.push(inst.References[0])
                    break
                case 'DYNAMICJMP':
                    ignoredInstructions.push(inst)
                    break
                case 'DCONSTS':
                case 'VERIFY':
                    ignoredInstructions.push(inst)
                    break
            }

            if (inst.BackReferences.length > 0) {
                ignoredInstructions.push(inst)
            }

            if (inst.IgnoreInstruction) {
                ignoredInstructions.push(inst)
            }
        }

        instrPoint++
    }

    ProcessInstr()
    let usedNames = {}
    superOperators.forEach((v, i) => {
        let superopName
        do {
            superopName = `${genChars(16)}`
        } while (usedNames[superopName] === true)
        usedNames[superopName] = true

        //chunk.Tree.Chunk.UsedInstructions[superopName] = true
        v.Name = superopName
        chunk.Tree.Chunk.Virtuals.push(v)

        let A = chunk.Tree.Opmap[superopName]
        if (chunk.Tree.Opmap[superopName] === null || chunk.Tree.Opmap[superopName] === undefined) {
            A = superopName
            if (!settings.Debug) {
                do {
                    A = `x${genChars(1)}${generateString(10)}`
                } while (chunk.Tree.ROpmap[A])
            }
        }

        chunk.Tree.ROpmap[A] = superopName
        chunk.Tree.Opmap[superopName] = A
        let idx = chunk.Instr.indexOf(v.Instructions[0]) 
        if (chunk.Instr.indexOf(v.Instructions[0]) === -1) {
            idx = v.InstrPoint
        }

        chunk.Instr.splice(idx, 0, {
            '1': 0,
            '2': 0,
            '3': null,
            IsSuperOp: true,
            Enum: superopName,
            Value: 0,
            Type: 'SOP',
            Name: superopName,
            Instructions: v.Instructions,
            Virtuals: v.Virtuals
        })

    })
}


function visitChunk(chunk, opmap, settings = {}, top = false) {

    chunk.Name = undefined
    chunk.FirstL = undefined
    chunk.LastL = undefined
    chunk.Vargs = undefined
    chunk.Stack = undefined

    chunk.Lines = undefined
    chunk.Locals = undefined
    chunk.Upvalues = undefined

    let consts = chunk.Const.map(v => v)
    let fakeConstants = [ 
        'herrtt is sexy', 'melancholy is weird>:(', 'game', 'HttpGet', 'require', 'loadstring', 'assert', 'load', 'workspace',
        'tonumber', 'gmatch', 'gsub', 'string', 'tostring', 'pcall', 'error', 'setmetatable', 'getrawmetatable', 'getmetatable',
        'rawget', 'rawset', 'char',' byte', 'len', 'assert', 'gBits8', 'gString', 'gSizet', 'gBits32', 'gBits64', 'gInt', 'Args',
        'Name', 'Vargs', 'Stack', 'Decode', 'syn', 'encrypt', 'decrypt', 'encode', 'OpargR', 'constants', 
        'whitelisted', 'wally is gay', 'Synapse XEn WInNing', 'pairs', 'select', 'assert', 'pcall', 'typeof',
        'type', 'unpack', 'coroutine', 'table', 'rawget', 'rawset', 'new', '__instr__', '__const__', '__init__',
        'tostring', 'Chunk', 'sizeof'
    ]
    let l = chunk.Const.length + 3
    consts.push('HERRTT FUSCATOR > ALL')
    for (let i = 0; i < l; i++)
        consts.push(fakeConstants[Math.floor(Math.random() * fakeConstants.length)])
    
    let constIdx = shuffleArray( consts.map((v, i) => i) )
    let newConst = []
    constIdx.forEach((v, i) => {
        newConst[v] = consts[i]
    })

    chunk.Const = newConst

    //console.log(["XORPRIM", chunk.Tree.XORPrimary, "XORSEC:", chunk.Tree.XORSecondary, "XORThird:", chunk.Tree.XORDecodeCKey])
    
    // Encrypt Constants
    // This doesn't work for some reason
    for (let Idx = 0; Idx < chunk.Const.length; Idx++) {
        //console.log(chunk.Const[Idx], chunk.Const[Idx].constructor, xorStrArr(chunk.Const[Idx], chunk.Tree.XORDecodeCKey))
        if (chunk.Const[Idx] !== null && (typeof chunk.Const[Idx] === 'string' || chunk.Const[Idx].constructor == Array)) {
            chunk.Const[Idx] = {
                Encrypted: true,
                Type: typeof chunk.Const[Idx],
                Orig: chunk.Const[Idx], 
                Data: xorStrArr(chunk.Const[Idx], chunk.Tree.XORDecodeCKey)
            }
        }
    }

    chunk.Tree.AddOpcode(chunk, 0, "DCONSTS", {
        Value: 0,
        Type: 'NOP',
        Mode: 4,
        Name: 'DCONSTS'
    })

    let encedConsts = {}
    for (let Idx = 0; Idx < chunk.Instr.length; Idx++) {
        let inst = chunk.Instr[Idx]
        if (inst !== null) {
            switch (inst.Name) {
                // Only Kst(n)
                case 'LOADK': // Kst(Bx) ...
                case 'GETGLOBAL':
                case 'SETGLOBAL':
                    inst['2'] = constIdx[inst['2']]
                    break

                // Both RK(B) & RK(C)
                case 'SETTABLE':

                case 'EQ':
                case 'LT':
                case 'LE':
                    
                case 'ADD':
                case 'SUB':
                case 'MUL':
                case 'DIV':
                case 'MOD':
                case 'POW':
                    if (inst['2'] >= 256)
                        inst['2'] = constIdx[inst['2'] - 256] + 256
                    
                // Only RK(C)
                case 'GETTABLE':
                case 'SELF':
                    if (inst['3'] >= 256)
                        inst['3'] = constIdx[inst['3'] - 256] + 256
                    break

                default: break;
            }

            if (settings.MaximumSecurity && (inst.Name === 'LOADK' || inst.Name === 'GETGLOBAL' || inst.Name === 'SETGLOBAL') && typeof chunk.Const[inst['2']] === 'string') {
                inst.Name = `${inst.Name}_ENC`
                inst.Enum = inst.Name
                if (typeof encedConsts[chunk.Const[inst['2']]] !== "number") {

                    //console.log(chunk.Const[inst['2']], xorStrArr(chunk.Const[inst['2']], chunk.Tree.XORPrimary))
                    // Have to update all instructions that use constants, and I am very much lazy
                    //chunk.Const[inst['2']] = xorStrArr(chunk.Const[inst['2']], chunk.Tree.XORPrimary)

                    // So I just create a new const
                    let newCi = chunk.Const.length
                    encedConsts[chunk.Const[inst['2']]] = newCi
                    if (typeof chunk.Const[inst['2']] === 'string')
                        chunk.Const[newCi] = xorStrArr(chunk.Const[inst['2']], chunk.Tree.XORPrimary)
                    else
                        chunk.Const[newCi] = chunk.Const[inst['2']]
                    inst['2'] = newCi
                } else {
                    //console.log(chunk.Const[inst['2']], encedConsts[chunk.Const[inst['2']]])
                    inst['2'] = encedConsts[chunk.Const[inst['2']]]
                }

                let exists = opmap[inst.Enum]
                let A = opmap[inst.Enum]

                if (A === null || A === undefined) {
                    A = inst.Name
                    if (!settings.Debug) {
                        do {
                            A = `x${genChars(1)}${generateString(10)}`
                        } while (chunk.Tree.ROpmap[A])
                    }
                }

                if (!exists) {
                    chunk.Tree.Chunk.UsedInstructions[inst.Name] = true
                    chunk.Tree.ROpmap[A] = inst.Name
                    chunk.Tree.Opmap[inst.Name] = A
                }


                if (inst !== null && opmap[inst.Enum] !== undefined && opmap[inst.Enum] !== null)
                    inst.Enum = opmap[inst.Enum]
            } else {
                // Randomize opcodes
                if (inst !== null && opmap[inst.Enum] !== undefined && opmap[inst.Enum] !== null)
                    inst.Enum = opmap[inst.Enum]   
            }
        }
    }


    if (top === true && settings.UseSuperops)
        generateSuperOperators(chunk, settings)

    for (let Idx = 0; Idx < chunk.Proto.length; Idx++) {
        visitChunk(chunk.Proto[Idx], opmap, settings)
    }
}

function grabShit() {
    let opmap = {}
    let ropmap = {}
    for (let Idx = 0; Idx < opdata.Opnames.length; Idx++) {
        let A = opdata.Opnames[Idx]
        ropmap[A] = Idx
        opmap[Idx] = A
    }

    return [ opmap, ropmap ]
}

module.exports = {
    ModifyTree: (tree, settings) => {

        tree.XORPrimary = genChars(10)//'O5ouoU_834'//generateString(10)
        tree.XORSecondary = genChars(11)//'i9x1X2u8I42'//generateString(11)
        tree.XORDecodeCKey = genChars(12)//'OU9oI43oo6IO'//generateString(12)

        tree.B64Key = shuffleString(_keyStr) + '='
        _keyStr = tree.B64Key

        let [ opmap, ropmap ] = (settings.Debug !== true || settings.RenameInstructions === true) ? scrambleOpcodes()  : grabShit()
        if (tree.OpQueue != undefined)
            for (let Idx = 0; Idx < tree.OpQueue.length; Idx++) {
                let n = tree.OpQueue[Idx]
                let A
                if (settings.Debug)
                    A = n
                else
                    do {
                        A = `x${genChars(1)}${generateString(10)}`
                    } while (ropmap[A])
                ropmap[A] = n
                opmap[n] = A
            }
    
        tree.Opmap = opmap
        tree.ROpmap = ropmap
        visitChunk(tree.Chunk, opmap, settings, true)
        tree.Headers.Signature = 'Herrtt Obfuscator'

        if (settings.Debug !== true && settings.AntiTamper === true) {
            tree.AddOpcode(tree.Chunk, 0, "VERIFY", {
                Value: 1,
                Type: 'AsBx',
                Mode: 4,
                Name: 'VERIFY',

                '1': 0,
                '2': -52
            })
    
            tree.AddOpcode(tree.Chunk, 0, "CHECKLINE", {
                Value: 1,
                Type: 'AsBx',
                Mode: 4,
                Name: 'CHECKLINE',

                '1': 0,
                '2': -52
            })
        }

        return tree
    }
}






