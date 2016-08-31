'use strict'

import * as fs from 'fs'
import { join } from 'path'

const POSTS_DIRECTORY = jd('posts')
const files = fs.readdirSync(POSTS_DIRECTORY)
  .filter(file => file.indexOf('.md') > 0)
  .map(file => join(POSTS_DIRECTORY, file))

const posts = files.map(extractFrontMatter)

fs.writeFileSync(jd('data.json'), JSON.stringify({ posts }))

function extractFrontMatter(filepath) {

  const open = '{{{'
  const close = '}}}'
  const content = fs.readFileSync(filepath).toString()
  const start = content.indexOf(open) + 2
  const end = content.indexOf(close) + 1
  const JSONString = content.slice(start, end)
  const meta = JSON.parse(JSONString)

  return { meta, content }

}

function jd(s) {
  return join(__dirname, s)
}