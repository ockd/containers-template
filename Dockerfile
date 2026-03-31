FROM ghcr.io/anomalyco/opencode:latest

# 컨테이너 서비스 포트
EXPOSE 4096

# 비대화형 환경 설정
ENV TERM=dumb
ENV HOME=/root

# git 설치 및 최소 작업 디렉토리 생성 (OpenCode는 git repo 필수)
RUN apk add --no-cache git && \
    mkdir -p /workspace && \
    cd /workspace && \
    git init && \
    git config user.email "container@opencode.ai" && \
    git config user.name "OpenCode"

WORKDIR /workspace

# 셸 래퍼로 실행하여 오류 출력 캡처 및 포트 바인딩 보장
CMD ["sh", "-c", "echo 'Starting OpenCode serve...' && opencode serve --port 4096 --hostname 0.0.0.0 2>&1 || echo \"EXIT CODE: $?\""]
