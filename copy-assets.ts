'use strict'

import * as crypto from 'crypto';
import { join, dirname } from 'path'
import * as mkdirp from 'mkdirp'
import * as fs from 'fs'

const assets: string[] = require('./node_assets.json')

for (const asset of assets) {

  const sourcePath = join(__dirname, asset)
  const destinationPath = join(__dirname, asset.replace('node_modules', 'assets'))

  fs.readFile(sourcePath, (error, data) => {

    if (error) {
      throw error
    }

    if (assetChanged(sourcePath, destinationPath)) {
      return
    }

    mkdirp(dirname(destinationPath), (error, made) => {

      fs.writeFile(destinationPath, data.toString(), error => {

        if (error) {
          throw error
        }

      })

    })

  })

}

/**
 * This function makes sure that we do not override any
 * files in the assets folder that we have changed
 * 
 * @param {string} sourcePath
 * @param {string} destinationPath
 * @returns {boolean}
 */
function assetChanged(sourcePath: string, destinationPath: string): boolean {

  // Reads file because we are lazy
  const r = a => fs.readFileSync(a).toString()

  // Hashes a string to hex
  const h = a => crypto.createHash('sha256').update(a).digest().toString('hex')

  const sourceFile = r(sourcePath)
  const sourceHash = h(sourceFile)
  const destinationFile = r(destinationPath)
  const destinationHash = h(destinationFile)

  return !(destinationHash === sourceHash)

}
