import request from "supertest";
import express from "express";
import { collectDefaultMetrics, Counter, register } from "prom-client";

describe("STG Metrics", () => {
  const app = express();
  collectDefaultMetrics();

  // Custom metric
  const rpcRequests = new Counter({
    name: "stg_rpc_requests_total",
    help: "Total number of RPC requests",
  });

  app.get("/metrics", async (req, res) => {
    rpcRequests.inc();
    res.set("Content-Type", register.contentType);
    res.end(await register.metrics());
  });

  test("should expose metrics endpoint", async () => {
    const res = await request(app).get("/metrics");
    expect(res.status).toBe(200);
    expect(res.text).toContain("process_cpu_seconds_total");
  });

  test("should include custom STG metric", async () => {
    const res = await request(app).get("/metrics");
    expect(res.text).toContain("stg_rpc_requests_total");
  });
});
