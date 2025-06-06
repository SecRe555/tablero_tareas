import type { JSX } from "solid-js";
export function ConfirmIcon(props: JSX.IntrinsicElements["svg"], key: string) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="1em"
      height="1em"
      viewBox="0 0 24 24"
      {...props}
    >
      <mask id="IconifyId1974628586e221d48436">
        <g
          fill="none"
          stroke="#fff"
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
        >
          <path
            fill="#fff"
            fill-opacity="0"
            stroke-dasharray="64"
            stroke-dashoffset="64"
            d="M3 12c0 -4.97 4.03 -9 9 -9c4.97 0 9 4.03 9 9c0 4.97 -4.03 9 -9 9c-4.97 0 -9 -4.03 -9 -9Z"
          >
            <animate
              fill="freeze"
              attributeName="fill-opacity"
              begin="0.6s"
              dur="0.5s"
              values="0;1"
            />
            <animate
              fill="freeze"
              attributeName="stroke-dashoffset"
              dur="0.6s"
              values="64;0"
            />
          </path>
          <path
            stroke="#000"
            stroke-dasharray="14"
            stroke-dashoffset="14"
            d="M8 12l3 3l5 -5"
          >
            <animate
              fill="freeze"
              attributeName="stroke-dashoffset"
              begin="1.1s"
              dur="0.2s"
              values="14;0"
            />
          </path>
        </g>
      </mask>
      <rect
        width="24"
        height="24"
        fill="currentColor"
        mask="url(#IconifyId1974628586e221d48436)"
      />
    </svg>
  );
}
