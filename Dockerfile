FROM ghcr.io/anomalyco/opencode:latest

# 컨테이너 서비스 포트
EXPOSE 4096

# 비대화형 환경 설정
ENV TERM=dumb

# git 설치 및 최소 작업 디렉토리 생성 (OpenCode는 git repo 필수)
RUN apk add --no-cache git && \
    mkdir -p /workspace && \
    cd /workspace && \
    git init && \
    git config user.email "container@opencode.ai" && \
    git config user.name "OpenCode"

WORKDIR /workspace

# 웹 서버 모드로 기동
CMD ["opencode", "serve", "--port", "4096", "--hostname", "0.0.0.0"]
