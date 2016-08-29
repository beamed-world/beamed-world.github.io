'use strict'

import { join } from 'path'
import * as fs from 'fs'

// 1line4lyf
fs.writeFileSync(join(__dirname, 'posts/index.json'), JSON.stringify(fs.readdirSync(join(__dirname, 'posts')), null, '  '))