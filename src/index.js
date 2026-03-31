import { Container } from "@cloudflare/containers";
import { env } from "cloudflare:workers";

// OpenCode 컨테이너 Durable Object 클래스
export class OpenCodeContainer extends Container {
  // OpenCode serve 모드 포트
  defaultPort = 4096;

  // 유휴 시 자동 절전 (10분)
  sleepAfter = "10m";

  // 컨테이너 환경변수 주입 (공식 환경변수명 사용)
  envVars = {
    OPENCODE_SERVER_PASSWORD: env.PASSWORD,
    OPENCODE_SERVER_USERNAME: "opencode",
  };

  onStart() {
    console.log("OpenCode 컨테이너 시작");
  }

  onStop() {
    console.log("OpenCode 컨테이너 중지");
  }

  onError(error) {
    console.error("OpenCode 컨테이너 오류:", error);
  }
}

// Worker fetch 핸들러 - 모든 요청을 싱글톤 컨테이너로 프록시
export default {
  async fetch(request, env) {
    const container = env.OPENCODE_CONTAINER.idFromName("singleton");
    const stub      = env.OPENCODE_CONTAINER.get(container);
    return stub.fetch(request);
  },
};
