#!/usr/bin/env node
const fs = require('fs')
const {
  js: BeautifyJs
} = require('js-beautify')
const { extname } = require('path')

function beautify(filepath) {
  if (fs.lstatSync(filepath).isDirectory()) {
    const files = fs.readdirSync(filepath)
    for (let file of files) {
      if (['.', '..'].includes(file)) continue
      beautify(filepath + '/' + file)
    }
    return
  }
  if (['.js', '.json'].includes(extname(filepath))) {
    fs.writeFileSync(filepath, BeautifyJs(fs.readFileSync(filepath).toString(), {
      indent_size: 2,
      space_in_empty_paren: true
    }))
  } else console.log(filepath)
}

if(process.argv[2]) {
 for(let i=2; i<process.argv.length; i++) {
   beautify(process.argv[i])
 }
}else{
  beautify('.')
}