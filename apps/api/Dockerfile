FROM docker.io/node:lts-alpine

WORKDIR /app

RUN apk add --no-cache dumb-init
RUN addgroup --system nodejs && adduser --system -G nodejs nodejs

COPY apps/api/dist/package.json ./
RUN npm install --only=production && npm cache clean --force

COPY --chown=nodejs:nodejs apps/api/dist ./

ENV NODE_ENV=production
USER nodejs

ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "main.js"]
