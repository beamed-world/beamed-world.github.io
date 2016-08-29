'use strict'

import { join } from 'path'
import * as fs from 'fs'

const elm = require('elm/binwrap')
const elmx = require('elmx')
const { walk } = require('fs-extra-promise')

const walker = walk(join(__dirname, 'source'))

walker.on('error', error => console.error(error))

walker.on('data', data => {

  const x = '.x.elm'
  const { path } = data

  if (path.includes(x)) {

    const outputPath = path.replace(x, '.elm')

    try {
      elmxMake(path, outputPath)
    } catch (error) {
      console.error(error)
    }

  }

})

walker.on('end', () => {

  const elmInputFile = join(__dirname, 'source/Main.elm')
  const elmOutputFile = join(__dirname, 'elm.js')

  elmMake(elmInputFile, elmOutputFile)

})

export function elmMake(inputFile: string, outputFile: string): void {

  const argvCopy = [...process.argv]

  process.argv = [ , , inputFile, '--output', outputFile]

  elm('elm-make')

  process.argv = argvCopy

}

/**
 * Takes two strings and does the elmx to elm transformation to them
 *
 * @export
 * @param {string} inputFile
 * @param {string} outputFile
 */
export function elmxMake(inputFile: string, outputFile: string): void {

  const elmxFile = fs.readFileSync(inputFile).toString()

  const elmSource = elmx(elmxFile)

  fs.writeFileSync(outputFile, elmSource)

}