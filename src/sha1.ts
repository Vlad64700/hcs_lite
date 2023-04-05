import { Buffer } from "buffer"


let a_array : Array<string> = new Array();
let b_array : Array<string> = new Array();
let c_array : Array<string> = new Array();
let d_array : Array<string> = new Array();
let e_array : Array<string> = new Array();


let a1_array: Array<string> = new Array();
let b1_array: Array<string> = new Array();
let c1_array: Array<string> = new Array();
let d1_array: Array<string> = new Array();
let e1_array: Array<string> = new Array();

const left_rotate = (a: number, n: number = 1): number => {
	let str: string = integer_to_binary(a)
	let out_str: string = str

	for (let i = 0; i < n; i++) {
		out_str = out_str + "0"
	}

	while (out_str.length > 32) {
		out_str = out_str.slice(1)
	}
	return binaty_strintg_to_int(out_str)
}

//функция вернет количество бит которые различаются
const change_bit = (a: string, b: string): number => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	while (b.length < 32) {
		b = "0" + b
	}
	while (b.length > 32) {
		b = b.slice(1)
	}

	let out_count: number = 0

	for (let i = 0; i < 32; i++) {
		if (a[i] !== b[i]) {
			out_count++
		}
	}
	return out_count
}

//перевод целого числа в двоичный код
const integer_to_binary = (dec: number): string => {
	return dec.toString(2)
}

const binaty_strintg_to_int = (str: string): number => {
	return parseInt(str, 2)
}

//перевод код из таблицы в двоичный код
const ascii_to_binary = (dec: number): string => {
	let out_str: string = (dec >>> 0).toString(2)
	while (out_str.length < 8) {
		out_str = "0" + out_str
	}
	return out_str
}

// функция перевода текста в битовую строку
export const str_to_bit = (p_str: string): string => {
	let out_buff_binary: string = ""
	let buf_ascii = Array.from(Buffer.from(p_str, "ascii"))
	for (let i = 0; i < buf_ascii.length; i++) {
		out_buff_binary += ascii_to_binary(buf_ascii[i])
	}
	return out_buff_binary
}

const operator_xor = (a: string, b: string) => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	while (b.length < 32) {
		b = "0" + b
	}
	while (b.length > 32) {
		b = b.slice(1)
	}

	let out_str: string = ""
	for (let i = 0; i < 32; i++) {
		if (a[i] === "0" && b[i] === "0") {
			out_str += "0"
		} else if (a[i] === "1" && b[i] === "1") {
			out_str += "0"
		} else {
			out_str += "1"
		}
	}

	return out_str
}

const operator_and = (a: string, b: string) => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	while (b.length < 32) {
		b = "0" + b
	}
	while (b.length > 32) {
		b = b.slice(1)
	}

	let out_str: string = ""
	for (let i = 0; i < 32; i++) {
		if (a[i] === "1" && b[i] === "1") {
			out_str += "1"
		} else {
			out_str += "0"
		}
	}

	return out_str
}

const operator_or = (a: string, b: string) => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	while (b.length < 32) {
		b = "0" + b
	}
	while (b.length > 32) {
		b = b.slice(1)
	}

	let out_str: string = ""
	for (let i = 0; i < 32; i++) {
		if (a[i] === "0" && b[i] === "0") {
			out_str += "0"
		} else {
			out_str += "1"
		}
	}

	return out_str
}

const operator_not = (a: string) => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	let out_str: string = ""
	for (let i = 0; i < 32; i++) {
		if (a[i] === "1") {
			out_str += "0"
		} else {
			out_str += "1"
		}
	}

	return out_str
}

const operator_sum = (a: string, b: string) => {
	while (a.length < 32) {
		a = "0" + a
	}
	while (a.length > 32) {
		a = a.slice(1)
	}

	while (b.length < 32) {
		b = "0" + b
	}
	while (b.length > 32) {
		b = b.slice(1)
	}

	let out_str: string = ""
	let num_1: number = binaty_strintg_to_int(a)
	let num_2: number = binaty_strintg_to_int(b)

	let num_itog: number = num_1 + num_2

	out_str = integer_to_binary(num_itog)
	while (out_str.length < 32) {
		out_str = "0" + out_str
	}
	while (out_str.length > 32) {
		out_str = out_str.slice(1)
	}

	return out_str
}

//шаг 1 алгоритма добавляем дополнительные биты
const step_1 = (buf: string): string => {
	//сперва нужно добавить бит '1'
	buf += "1"
	let n: number
	//количество нулей, которое необходимо добавить
	//по условию L = 448 (mod 512)
	//а если простым языком то надо просто сделать так чтобы общая длинна сообщения была 448 и ВСЕ
	if (buf.length % 512 < 448) {
		n = 448 - (buf.length % 512)
	} else {
		n = 512 - ((buf.length % 512) - 448)
	}
	//добавляем количество нулей
	for (let i = 0; i < n; i++) {
		buf += "0"
	}
	let h = buf.length % 512
	return buf
}

//шаг 2 алгоритма добавление исходной длины сообщения
const step_2 = (
	buf: string,
	original_message: string
): Array<Array<string>> => {
	let original_message_binary = str_to_bit(original_message)
	//на этом шаге надо добавить к сообщению МЛАДШИЕ 64 бита значения длинны сообщения
	let out_str: string = buf
	//переводим значение длинны в двоичный формат
	let n: string = integer_to_binary(original_message_binary.length)

	//добавляем младшие 64 бита длинны, если меньше 64 бита, то добавляем старшие биты нулями
	if (n.length < 64) {
		for (let i = 0; i < 64 - n.length; i++) {
			out_str += "0"
		}
		out_str += n
	} else {
		out_str += n.slice(n.length - 64)
	}

	//   console.log(out_str.slice(0,8))
	//   console.log(out_str.slice(8,16))
	//   console.log(out_str.slice(16,24))
	//   console.log(out_str[24])
	//   console.log(out_str.slice(25,448))
	//   console.log(out_str.slice(25,448).length)
	//   console.log(out_str.slice(448))
	//   console.log(out_str.slice(448).length)

	//полученное сообщение надо разбить на блоки 512 бит
	//каждый из которых затем надо разбить на 16 32-битных блоков
	let out_array_messsage = new Array<Array<string>>()
	let temp_str: string
	for (let i = 0; i < out_str.length / 512; i++) {
		temp_str = out_str.slice(512 * i, 512 * i + 512)
		//добавляем путой массив
		out_array_messsage.push([])
		//загружам в него 16 32-битных слов
		for (let j = 0; j < 16; j++) {
			out_array_messsage[i].push(temp_str.slice(j * 32, j * 32 + 32))
		}
	}

	return out_array_messsage
}

//шаг 3 формирование итогового сообщения
const step_3 = (
	in_str: Array<Array<string>>
): { out_SHA_1: string; r: Array<number> } => {
	let out_str = new Array<Array<number>>()

	let r: Array<number> = new Array<number>()
	//переменные которые будут нужны по ходу дела алгоритма
	let k: number
	let f: number
	let temp: string

	//определим константу H
	let H = new Array<string>()
	H.push("01100111010001010010001100000001")
	H.push("11101111110011011010101110001001")
	H.push("10011000101110101101110011111110")
	H.push("00010000001100100101010001110110")
	H.push("11000011110100101110000111110000")

	//ОСНОВНОЙ ЦИКЛ
	//обрабатываем каждый 512-битный блок нашего сообщения
	for (let i = 0; i < in_str.length; i++) {
		out_str.push([])
		//16 слов по 32-бита дополняются до 80 32-битовых слов
		//первые 16 слов не меняются
		for (let j = 0; j <= 15; j++) {
			out_str[i].push(binaty_strintg_to_int(in_str[i][j]))
		}
		//далее слова формируются через алгоритм на википедии
		for (let j = 16; j <= 79; j++) {
			let j1 = operator_xor(in_str[i][j - 3], in_str[i][j - 8])
			let j2 = operator_xor(j1, in_str[i][j - 14])
			let j3 = operator_xor(j2, in_str[i][j - 16])
			j3 = j3.slice(1) + j3[0]
			in_str[i].push(j3)

			out_str[i].push(binaty_strintg_to_int(in_str[i][j]))
		}

		//иницилизация рабочих переменных
		let a: string = H[0]
		let b: string = H[1]
		let c: string = H[2]
		let d: string = H[3]
		let e: string = H[4]

		let f_dop: string

		for (let j: number = 0; j <= 79; j++) {
			// для подсчета изменившихся бит
			let a1: string = a
			let b1: string = b
			let c1: string = c
			let d1: string = d
			let e1: string = e
			if (0 <= j && j <= 19) {
				f_dop = operator_or(
					operator_and(b, c),
					operator_and(operator_not(b), d)
				)
				f = binaty_strintg_to_int(f_dop)
				k = 0x5a827999
			} else if (20 <= j && j <= 39) {
				f_dop = operator_xor(operator_xor(b, c), d)
				f = binaty_strintg_to_int(f_dop)
				k = 0x6ed9eba1
			} else if (40 <= j && j <= 59) {
				f_dop = operator_or(
					operator_or(operator_and(b, c), operator_and(b, d)),
					operator_and(c, d)
				)
				f = binaty_strintg_to_int(f_dop)
				k = 0x8f1bbcdc
			} else if (60 <= j && j <= 79) {
				f_dop = operator_xor(operator_xor(b, c), d)
				f = binaty_strintg_to_int(f_dop)
				k = 0xca62c1d6
			} else {
				f_dop = ""
				k = 0
			}

			temp = operator_sum(a.slice(5) + a.slice(0, 5), f_dop)
			temp = operator_sum(temp, e)
			temp = operator_sum(temp, integer_to_binary(k))
			temp = operator_sum(temp, in_str[i][j])

			e = d
			d = c
			c = b.slice(30) + b.slice(0, 30)
			b = a
			a = temp

			r.push(
				change_bit(a, a1) +
					change_bit(b, b1) +
					change_bit(c, c1) +
					change_bit(d, d1) +
					change_bit(e, e1)
			)
		}

		H[0] = operator_sum(H[0], a)
		H[1] = operator_sum(H[1], b)
		H[2] = operator_sum(H[2], c)
		H[3] = operator_sum(H[3], d)
		H[4] = operator_sum(H[4], e)
	}

	let out_SHA_1: string =
		binaty_strintg_to_int(H[0]).toString(16) +
		" " +
		binaty_strintg_to_int(H[1]).toString(16) +
		" " +
		binaty_strintg_to_int(H[2]).toString(16) +
		" " +
		binaty_strintg_to_int(H[3]).toString(16) +
		" " +
		binaty_strintg_to_int(H[4]).toString(16)

	return { out_SHA_1, r }
}

//--------------------MAIN FUNCTION!!!--------------------
export const SHA_1 = (
	message: string
): { out_SHA_1: string; r: Array<number> } => {
	let out_message: string

	//перевод строки в битовую строку
	out_message = str_to_bit(message)
	//шаг 1 алгоритма
	out_message = step_1(out_message)

	//швг 2
	let array_messages: Array<Array<string>>
	array_messages = step_2(out_message, message)

	let out_sha_1 = step_3(array_messages)
	return out_sha_1
}

export const SHA_1_for_bit_string = (
	message: string
): string => {
	let out_message: string

	//перевод строки в битовую строку
	out_message = str_to_bit(message)
	//шаг 1 алгоритма
	out_message = step_1(message)

	//швг 2
	let array_messages: Array<Array<string>>
	array_messages = step_2(out_message, message)

	let out_sha_1 = step_3(array_messages)
	return out_sha_1.out_SHA_1
}

