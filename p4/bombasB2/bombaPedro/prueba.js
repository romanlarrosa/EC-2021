const stri = 'JruGinOst'

const fun = (str) => {
  let ret = ''
  for (const i of str) {
    if (i % 2 == 0) {
      console.log(i)
      //console.log(String.fromCharCode(i.charAt(0)))
    } else {
      console.log(i)
      //console.log(String.fromCharCode(i.charAt(0)))
    }
  }
  return ret
}

fun(stri)
