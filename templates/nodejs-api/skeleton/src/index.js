const express = require('express');

const app = express();
const port = process.env.PORT || ${{ values.port }};

// Health check exigido pela PoC
app.get('/health', (_req, res) => {
  res.json({ status: 'healthy' });
});

app.get('/', (_req, res) => {
  res.json({ service: '${{ values.appName }}', status: 'running' });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`${{ values.appName }} listening on port ${port}`);
});
