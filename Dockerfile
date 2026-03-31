FROM ghcr.io/anomalyco/opencode:latest

# 컨테이너 서비스 포트
EXPOSE 4096

# 비대화형 환경 설정
ENV TERM=dumb

# 웹 서버 모드로 기동 (외부 접근 가능하도록 0.0.0.0 바인딩)
ENTRYPOINT ["opencode"]
CMD ["serve", "--port", "4096", "--hostname", "0.0.0.0"]
