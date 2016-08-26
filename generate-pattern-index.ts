'use strict'

import { join } from 'path'
import { readdir, writeFile } from 'fs'

readdir(join(__dirname, 'assets/patterns'), (error, files) => {

  if (error) {
    throw error
  }

  const images = files.filter(filename => filename.indexOf('.png') > -1)

  const imageJSON = JSON.stringify(images)
  const imageJavascript = `var images = ${imageJSON}`

  writeFile(join(__dirname, 'assets/patterns/index.json'), imageJSON, error => {

    if (error) {
      throw error
    }

    console.log('Successfully wrote pattern index')

  })

  writeFile(join(__dirname, 'assets/patterns/index.js'), imageJavascript, error => {

    if (error) {
      throw error
    }

    console.log('Successfully wrote pattern javascript file')

  })

})